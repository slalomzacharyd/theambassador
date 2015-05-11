class db::service {
    supervisord::program { 'mysql':
        command => '/usr/bin/mysqld_safe --basedir=/usr',
        priority => '100',
        environment => {},
        require => [Package["mariadb-server"]],
        user => 'mysql',
        autorestart => false,
        autostart => true,
    }
    exec {'stop mariadb hack':
        command => 'systemctl stop mariadb;systemctl disable mariadb;sleep 1s;supervisorctl reload;sleep 1s;',
        path => '/usr/bin',
        require => Supervisord::Program['mysql'],
    }
}
