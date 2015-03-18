class hostname ($hostname = 'theambassador') {
    file { '/etc/hostname':
        ensure => file,
        owner => "root",
        group => "root",
        content => template("hostname/hostname.erb"),
    }

    file { '/etc/hosts':
        ensure => file,
        owner => "root",
        group => "root",
        content => template("hostname/hosts.erb"),
    }
}
