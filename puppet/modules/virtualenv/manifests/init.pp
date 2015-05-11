class virtualenv($path, $env_name, $user) {
    exec { "virtualenv ${path}/${env_name}":
        cwd => $path,
        user => $user,
        path => ["/usr/bin"],
        creates => "${path}/${env_name}",
        require => Class["virtualenv::install"]
    }

    contain virtualenv::install
}
