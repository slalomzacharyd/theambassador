class db::install {
    $packages = [
        'mariadb', 'mariadb-server', 'mariadb-devel'
    ]
    package { $packages:
        ensure => present
    }
}
