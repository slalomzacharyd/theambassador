class supervisor::config () {
   file {"/etc/supervisord-background.conf":
        owner => 'root',
        group => 'root',
        ensure => file,
        content => template("supervisor/supervisord-background.conf.erb"),
    }
}
