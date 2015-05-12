class supervisor::service {
    $restart = "/usr/bin/supervisord -c /etc/supervisord-background.conf; /usr/bin/supervisord reload; true"
    if $virtual == 'docker' {
        exec {$restart:
            path => '/usr/bin',
            require => Package['supervisor'],
        }
    }
    else {
        exec {$restart:
            command => 'true',
            path => '/usr/bin',
            require => Package['supervisor'],
        }
    }
}
