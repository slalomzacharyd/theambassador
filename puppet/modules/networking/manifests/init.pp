class networking ($hostname) {
    package {'hostname':
        ensure => present,
        allow_virtual => true,
    }

    file { '/etc/hosts':
        ensure => file,
        owner => "root",
        group => "root",
        content => template("networking/hosts.erb"),
        require => Package['hostname'],
    }
}
