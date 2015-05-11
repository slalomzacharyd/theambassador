class supervisor::install {
    class {'supervisord': 
        package_provider => 'yum',
        install_init => false,
        service_name => 'supervisord'
    }
}

