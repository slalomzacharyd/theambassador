class nginx {
    package {"nginx":
        ensure => "latest",
        allow_virtual => false
    }
}
