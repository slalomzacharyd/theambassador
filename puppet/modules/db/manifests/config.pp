class db::config ($root, $users) {
    $root_password = $root['password']

    class { '::mysql::server':
        create_root_user => true,
        root_password => $root_password,
        remove_default_accounts => true,
        service_enabled => true,
    }

    define createUsers ($users) {
        $username = $name
        $details = $users[$username]
        mysql_user { $username:
            ensure => present,
            max_connections_per_hour => 0,
            max_queries_per_hour => 0,
            max_updates_per_hour => 0,
            max_user_connections => 0,
            password_hash => mysql_password('something'),
        }
    }

    $usernames = keys($users)
    createUsers{$usernames:
        users => $users
    }
}
