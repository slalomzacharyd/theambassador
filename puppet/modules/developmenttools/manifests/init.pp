class developmenttools () {
    $packages = [
        'gcc', 'libstdc++-devel', 'glibc-devel', 'gettext-devel', 'glibc-headers',
    ]

    package {$packages:
        ensure => installed,
        allow_virtual => false,
    }
}
