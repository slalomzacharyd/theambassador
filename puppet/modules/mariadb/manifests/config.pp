
class mariadb::config ($mariadb_password = "ZcJep8aCqJ3WmhQq7uUACCf9") {
    exec { "set-mariadb-root-password":
        unless => "mysqladmin -uroot -p$mariadb_password status",
        path => ["/bin", "/usr/bin"],
        command => "mysqladmin -uroot password $mariadb_password",
        require => Service["mariadb"],
    }

/*

    define db( $user, $password ) {
      exec { "create-${name}-db":
        unless => "/usr/bin/mysql -uroot ${name}",
        command => "/usr/bin/mysql -uroot -e \"create database ${name};\"",
        require => Service["mysqld"],
      }
    }
    mysql_install_db --user=mysql
*/
}
