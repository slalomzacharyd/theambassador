class login ($owner = 'vagrant', $group = 'vagrant', $path = "/home/vagrant") {
    file {"${path}/.bash_profile":
        owner => $owner,
        group => $group,
        ensure => file,
        content => template("login/bash_profile.erb"),
    }

    file {"${path}/.bash_banner":
        owner => $owner,
        group => $group,
        ensure => file,
        content => template("login/banner.erb"),
    }
}
