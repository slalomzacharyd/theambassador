class db::service {
    exec {'/usr/libexec/mariadb-prepare-db-dir':
        path => "/usr/bin",
    }
    supervisord::program { 'mysql':
        command => "bash -c '/usr/bin/mysqld_safe --basedir=/usr; /usr/libexec/mariadb-wait-ready'",
        priority => '100',
        environment => {},
        user => 'mysql',
        autorestart => false,
        autostart => true,
        require => [Package["mariadb-server"], Exec['/usr/libexec/mariadb-prepare-db-dir']],
    }

    exec {'reload-mysql':
        command => 'supervisorctl reload; /usr/libexec/mariadb-wait-ready; sleep 1s',
        path => "/usr/bin",
        require => [Supervisord::Program['mysql'], Exec["/usr/bin/supervisord -c /etc/supervisord.conf"]]
    }
}
