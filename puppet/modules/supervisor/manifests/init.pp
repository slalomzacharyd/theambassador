class supervisor {
    contain supervisor::install, supervisor::service, supervisor::config
}

Class['supervisor::install'] -> Class['supervisor::config'] -> Class['supervisor::service']
