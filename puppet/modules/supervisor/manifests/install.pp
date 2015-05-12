class supervisor::install {
    if $virtual == 'docker' {
        class {'supervisord':
            package_provider => yum,
            install_init => false,
            service_name => 'supervisord',
            service_manage => false,
            package_enable => false,
            service_ensure => stopped,
            nodaemon => true,
        }
    }
    else {
        class {'supervisord':
            package_provider => yum,
            install_init => false,
            service_name => 'supervisord',
            service_manage => true,
            package_enable => true,
            service_ensure => running,
            nodaemon => false,
        }
    }
}

