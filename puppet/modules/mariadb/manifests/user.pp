class mariadb::user ($database, $dbuser, $dbpassword) {
    prefix = "mysql -u root -p${rootdbpassword} -e "
    suffix = "; FLUSH PRIVILEGES;"
    exists = "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '${dbuser}')"

    exec {"CREATE USER ${dbuser} ITENTIFIED BY PASSWORD '$dbpassword'":
        command => "${prefix}\"${title}\"${suffix}",
        unless => "${prefix}\"${exists}\"${suffix}"
    }
}

Class['mariadb::user'] -> Class['mariadb::privileges']
