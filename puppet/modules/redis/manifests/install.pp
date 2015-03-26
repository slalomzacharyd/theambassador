class redis::install {
    package {'redis':
        ensure => latest,
        allow_virtual => false,
        require => Class['epel']
    }

    include epel
}
