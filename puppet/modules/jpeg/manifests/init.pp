class jpeg {
    package {"libjpeg-turbo-devel":
        ensure => latest,
        allow_virtual => false
    }
}
