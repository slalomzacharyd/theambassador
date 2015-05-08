class firewall::install() {
    package {'firewalld':
        ensure => 'present',
        allow_virtual => true,
    }
}
