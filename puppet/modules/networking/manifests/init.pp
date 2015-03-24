class networking ($hostname) {
    file { '/etc/hostname':
        ensure => file,
        owner => "root",
        group => "root",
        content => template("networking/hostname.erb"),
    }

    file { '/etc/hosts':
        ensure => file,
        owner => "root",
        group => "root",
        content => template("networking/hosts.erb"),
    }
}
