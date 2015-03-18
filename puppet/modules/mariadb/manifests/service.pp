
class mariadb::service {
    service { "mariadb":
        ensure => running,
        hasstatus => true,
        hasrestart => true,
        enable => true,
    }
}
