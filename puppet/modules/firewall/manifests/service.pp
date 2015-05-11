class firewall::service {
    service{'firewalld':
        ensure => running,
        enable => true,
        require => Class['firewall::config'],
    }
}
