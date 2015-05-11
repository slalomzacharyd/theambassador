class nginx {
    contain nginx::install, nginx::config, nginx::service
}

Class['nginx::install'] -> Class['nginx::config'] -> Class['nginx::service']
