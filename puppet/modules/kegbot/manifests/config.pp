class kegbot::config ($dbuser, $dbpassword, $database) {
    class {'mariadb::createDatabase':
        database => $database,
        dbuser => $dbuser,
        dbpassword => $dbpassword,
    }
}
