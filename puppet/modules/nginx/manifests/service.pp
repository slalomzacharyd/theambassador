class nginx::service {
    supervisord::program { "nginx":
        command => '/usr/sbin/nginx -g "daemon off;"',
        priority => '100',
        autostart => true,
        autorestart => false,
    }
}

