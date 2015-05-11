class nginx::install {
    package {"nginx":
        ensure => "latest",
        allow_virtual => true
    }

    
}

