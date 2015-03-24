class redis {
    package {'redis':
        ensure => latest,
        require => Class['epel'],
        allow_virtual => false,
    }

    include epel
}
