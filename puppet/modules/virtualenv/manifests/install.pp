class virtualenv::install {
    package { "python-virtualenv":
        allow_virtual => "false",
        ensure => "installed"
    }
}
