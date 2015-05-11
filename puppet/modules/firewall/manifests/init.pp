class firewall {
    contain firewall::config, firewall::service, firewall::install
}

Class['firewall::install'] -> Class['firewall::config'] -> Class['firewall:service']
