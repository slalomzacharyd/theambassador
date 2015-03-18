class login ($user = 'vagrant', $group = 'vagrant', $path = "/home/vagrant") {
    file {"bash_profile":
        path => "${path}/.bash_profile",
        owner => $user,
        group => $group,
        ensure => file,
        content => template("login/bash_profile.erb"),
    }

    file {"bash_banner":
        path => "${path}/.bash_banner",
        owner => $user,
        group => $group,
        ensure => file,
        content => template("login/banner.erb"),
    }
}
