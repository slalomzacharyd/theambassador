class redis::server {
    service{'redis':
        ensure => running,
        enable => true,
        require => Class['redis::install']
    }
}
