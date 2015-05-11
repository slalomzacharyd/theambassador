class kegbot::config ($applications) {
    $names = keys($applications)
    define createDatabases($applications) {
        $kegbot = $applications[$name]
        $dbname = $kegbot['db']['name']
        $databasecharset = $kegbot['db']['charset']
        $users = $kegbot['db']['users']
        $usernames = keys($users)

        mysql_database { $dbname:
            ensure => present,
            charset => $databasecharset,
            require => Class['db'],
        }

        createUserPermissions{$usernames:
            users => $users,
            applicationname => $name,
            require => Class['db'],
        }
    }

    define createUserPermissions($users, $applicationname) {
        $permissions = $users[$name]
        createGrants{$permissions: 
            username => $name,
            applicationname => $applicationname,
            require => Class['db'],
        }
    }

    define createGrants($username, $applicationname) {
        $permission = $name
        $grants = $permission['grants']
        $target = $permission['target']
        mysql_grant {"${username}/${target}":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => $grants,
            table      => $target,
            user       => $username,
            require    => Class['db'],
            before     => Exec["setup ${applicationname}"],
        }
    }

    createDatabases{$names:
        applications => $applications
    }

    define setupKegbots($applications) {
        $kegbot = $applications[$name]
        $dbname = $kegbot['db']['name']
        $dbusernames = keys($kegbot['db']['users'])
        if is_array($dbusernames) {
            $dbusername = $dbusernames[0]
        } else {
            $dbusername = $dbusernames
        }
        $dbusernameParts = split($dbusername, '@')
        $dbusernameShort = $dbusernameParts[0]

        $dbusers = hiera('db::config::users')
        $dbpassword = $dbusers[$dbusername]['password']
        $env_name = $kegbot['env_name']
        $path = $kegbot['path']
        $user = $kegbot['user']
        $group = $kegbot['group']
        $data_root = $kegbot['data_root']
        $access_rules = $kegbot['access_rules']
        $settings_dir = $kegbot['settings_dir']

        supervisord::program { "${name}-gunicorn":
            command => '/home/vagrant/kegbot/bin/gunicorn pykeg.web.wsgi:application -w 3',
            priority => '100',
            environment => {},
            directory => '/home/vagrant',
            user => 'vagrant',
            autostart => true,
            autorestart => false,
            require => File["/etc/nginx/conf.d/${name}.conf"],
        }

        supervisord::program { "${name}-workers":
            command => '/home/vagrant/kegbot/bin/kegbot run_workers',
            directory => '/home/vagrant',
            stopasgroup => true,
            user => 'vagrant',
            autostart => true,
            autorestart => false,
        }

        supervisord::group { "${name}":
            priority => 100,
            programs => ["${name}-gunicorn", "${name}-workers"],
            require => [Supervisord::Program["${name}-gunicorn"], Supervisord::Program["${name}-workers"]]
        }

        file {"/etc/nginx/sites-available/${name}.conf":
            content => template("kegbot/nginx.conf.erb"),
            require => Class['nginx'],
        }

        file {"/etc/nginx/conf.d/${name}.conf":
            ensure => link,
            target => "/etc/nginx/sites-available/${name}.conf",
            require => File["/etc/nginx/sites-available/${name}.conf"],
        }

        exec{"mkdir -p ${data_root}":
            path => "/usr/bin"
        }

        file {"${data_root}":
            ensure => directory,
            group => "nginx",
            owner => "vagrant",
            require => Exec["mkdir -p ${data_root}"],
        }
            

        $setup_kegbot_command = join([
            "setup-kegbot.py",
            "--allow_root=false",
            "--data_root=${data_root}",
            "--db_database=${dbname}",
            "--db_password=${dbpassword}",
            "--db_type=mysql",
            "--db_user=${dbusernameShort}",
            "--settings_dir=${settings_dir}",
            "--replace_settings=true",
            "--interactive=false",
            "--replace_data=false",
        ], " ")
        exec{"setup ${name}":
            command => "bash -c 'source ${path}/${env_name}/bin/activate; ${setup_kegbot_command}'",
            creates => $settings_dir,
            path => "/usr/bin",
            cwd => $path,
            group => $group,
            user => $user,
            require => [File["${data_root}"], Supervisord::Group["${name}"]]
        }

        file {"${path}/.bash_sources/${name}":
            ensure => file,
            content => template("kegbot/bashrc.erb"),
            group => $group,
            owner=> $user
        }
    }
    setupKegbots{$names:
        applications => $applications
    }
}
