class mariadb::privileges ($database, $dbuser, $dbpassword) {
    prefix = "mysql -u root -p${rootdbpassword} -e "
    suffix = "; FLUSH PRIVILEGES;"

    exec {"REVOKE ALL PRIVILEGES ON ${database}.* FROM '${dbuser}'@'localhost' IDENTIFIED BY '${dbpassword}'":
        command => "${prefix}\"${title}\"${suffix}",
        unless => "mysql -u ",
        require => Exec['CREATE DATABASE ${database}'],
        before => "GRANT ALL PRIVILEGES ON ${database}.* TO ${dbuser}@localhost IDENTIFIED BY '${dbpassword}'",
    }

    exec {"GRANT ALL PRIVILEGES ON ${database}.* TO ${dbuser}@localhost IDENTIFIED BY '${dbpassword}'":
        command => "${prefix}\"${title}\"${suffix}",
        unless => "mysql -u ",
        require => Exec['CREATE DATABASE ${database}'],
    }
}
