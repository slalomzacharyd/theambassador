class kegbot::install ($path, $env_name, $user) {
    exec {"bash -c 'source ${path}/${env_name}/bin/activate; pip install kegbot'":
        user => $user,
        path => "/usr/bin",
        creates => "${path}/${env_name}/bin/setup-kegbot.py",
        require => [ Class['virtualenv'] ],
    }

    class { 'virtualenv':
        path => $path,
        env_name => $env_name,
        user => $user,
    }


mysqladmin -u root -pBLAH create kegbot

mysql -u root -e '
  GRANT ALL PRIVILEGES ON kegbot.* TO kegbot@localhost
    IDENTIFIED BY "pw"; flush privileges;'

setup-kegbot.py --allow_root=False, --data_root 

  --allow_root: Allows this program to run as root. This is usually not required, and
    acts as a precaution against users unintentionally running the program with sudo.
    (default: 'False')
  --data_root: Data root for Kegbot.
    (default: '~/kegbot-data')
  --db_database: MySQL/Postgres database name.
    (default: 'kegbot')
  --db_password: MySQL/Postgres password.
    (default: '')
  --db_type: One of: mysql, postgres.
    (default: 'mysql')
  --db_user: MySQL/Postgres username.
    (default: 'root')

}
