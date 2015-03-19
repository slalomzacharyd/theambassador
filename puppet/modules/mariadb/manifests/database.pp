class mariadb::database ($database, $dbuser, $dbpassword) {
    prefix = "mysql -u root -p${rootdbpassword} -e "
    suffix = "; FLUSH PRIVILEGES;"
    exists = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '${database}'"

    exec {'CREATE DATABASE ${database}':
        command => "${prefix}\"${title}\"${suffix}",
        unless => "${prefix}\"${exists}\""
    }
}

Class['mariadb::database'] -> Class['mariadb::privileges']
