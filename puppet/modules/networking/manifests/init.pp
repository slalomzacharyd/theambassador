class networking ($hostname) {
    package {'hostname':
        ensure => present,
        allow_virtual => true,
    }
    host { $hostname:
        ensure => present,
        ip => "127.0.0.1",
        require => Package['hostname'],
    }

    file { '/etc/hosts':
        ensure => file,
        owner => "root",
        group => "root",
        content => template("networking/hosts.erb"),
        require => Package['hostname'],
    }
}
