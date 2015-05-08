class login ($users = hiera('login::users')) {
    $usernames = keys($users)
    define generateUsers($users) {
        $username = $title
        $settings = $users[$username]
        $home = $settings['home']
        $shell = $settings['shell']
        $group = $settings['group']
        user {$username:
            ensure => present,
            home => $home,
            managehome => true,
            shell => $shell,
            system => false,
        }
        file {"${home}/.bash_sources":
            ensure => "directory",
            owner => $username,
            group => $group,
            mode => "0700",
            purge => true,
            recurse => true,
            require => User[$username]
        }
        file {"${home}/.bash_profile":
            owner => $username,
            group => $group,
            ensure => file,
            content => template("login/bash_profile.erb"),
            require => [User[$username], File["${home}/.bash_sources"]],
        }

        file {"${home}/.bash_banner":
            owner => $username,
            group => $group,
            ensure => file,
            content => template("login/banner.erb"),
            require => User[$username],
        }
    }
    generateUsers{$usernames:
        users => $users
    }
}
