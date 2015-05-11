class redis::server {
    supervisord::program { "redis":
        command => '/usr/bin/redis-server /etc/redis.conf --daemonize no',
        priority => '100',
        autostart => true,
        autorestart => false,
    }
}
