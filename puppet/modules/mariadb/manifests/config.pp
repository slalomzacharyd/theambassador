
class mariadb::config ($mariadb_password = "ZcJep8aCqJ3WmhQq7uUACCf9") {
    exec { "set-mariadb-root-password":
        unless => "mysqladmin -uroot -p$mariadb_password status",
        path => ["/bin", "/usr/bin"],
        command => "mysqladmin -uroot password $mariadb_password",
        require => Service["mariadb"],
    }

    exec { "initialize-mariadb":
        unless =>
        path => ["/bin", "/usr/bin"],
        command => "mysql_install_db --user=mysql",
    }
}
