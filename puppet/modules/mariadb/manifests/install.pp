
class mariadb::install {
    $packages = ["mariadb", "mariadb-server", "mariadb-devel"]
    package { $packages:
        ensure => latest,
        allow_virtual => false
    }
}
