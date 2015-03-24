class epel {
    package {'epel-release':
        ensure => latest,
        allow_virtual => false,
    }
}
