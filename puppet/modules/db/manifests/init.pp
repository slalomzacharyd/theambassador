class db {
    contain db::install, db::config, db::service
}

Class["db::install"] -> Class["db::config"] -> Class['db::service']
