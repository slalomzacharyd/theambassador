class mariadb {
    include mariadb::install, mariadb::config, mariadb::service
}

Class["mariadb::install"] -> Class["mariadb::config"] -> Class["mariadb::service"]


