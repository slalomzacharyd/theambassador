class kegbot::install ($applications) {
    $names = keys($applications)
    define installKegbots($applications) {
        $kegbot = $applications[$name]
        $path = $kegbot['path']
        $env_name = $kegbot['env_name']
        $user = $kegbot['user']
        exec {"bash -c 'source ${path}/${env_name}/bin/activate; pip install --upgrade pip; pip install kegbot'":
            user => $user,
            path => "/usr/bin",
            creates => "${path}/${env_name}/bin/setup-kegbot.py",
            require => [ Class['virtualenv'], Class['db'] , Class['jpeg'], Class['nginx'], Class['supervisor']]
        }

        class { 'virtualenv':
            path => $path,
            env_name => $env_name,
            user => $user,
        }
    }

    installKegbots{$names:
        applications => $applications
    }

    include supervisor, jpeg, nginx
}
