class login ($users) {
    $usernames = keys($users)
    define generateUsers($users) {
        $username = $title
        $settings = $users[$username]
        $home = $settings['home']
        $shell = $settings['shell']
        $group = $settings['group']
        user {$user:
            ensure => present,
            groups => $group,
            home => $home,
            managehome => true,
            shell => $shell,
            system => false,
        }
        file {"${home}/.bash_profile":
            owner => $owner,
            group => $group,
            ensure => file,
            content => template("login/bash_profile.erb"),
            require => User[$user],
        }

        file {"${home}/.bash_banner":
            owner => $username,
            group => $group,
            ensure => file,
            content => template("login/banner.erb"),
            require => User[$user],
        }
    }
    generateUsers{$usernames:
        users => $users
    }
}
