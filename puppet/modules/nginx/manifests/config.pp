class nginx::config {
    file {'/etc/nginx/sites-available':
        ensure => directory,
        force => true,
    }
}
