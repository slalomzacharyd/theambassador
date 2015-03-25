class kegbot::config ($applications) {
    $names = keys($applications)
    define createDatabases($applications) {
        $kegbot = $applications[$name]
        $databasename = $kegbot['db']['name']
        $databasecharset = $kegbot['db']['charset']
        $users = $kegbot['db']['users']
        $usernames = keys($users)

        mysql_database { $databasename:
            ensure => present,
            charset => $databasecharset,
        }

        createUserPermissions{$usernames:
            users => $users
        }
    }

    define createUserPermissions($users) {
        $permissions = $users[$name]
        createGrants{$permissions: 
            username => $name
        }
    }

    define createGrants($username) {
        $permission = $name
        $grants = $permission['grants']
        $target = $permission['target']
        mysql_grant {"${username}/${target}":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => $grants,
            table      => $target,
            user       => $username,
        }
    }

    createDatabases{$names:
        applications => $applications
    }
}
