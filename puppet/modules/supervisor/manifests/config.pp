class supervisor::config {"/etc/supervisor/conft.d/kegbot.conf":
    source => template("supervisor/kegbot.conf.erb")
}
