class supervisor {
    package {"supervisor":
        ensure => latest,
        allow_virtual => false,
        require => Class['epel'],
    }
}
