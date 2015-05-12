class supervisor {
    contain supervisor::install, supervisor::service
}

Class['supervisor::install'] -> Class['supervisor::service']
