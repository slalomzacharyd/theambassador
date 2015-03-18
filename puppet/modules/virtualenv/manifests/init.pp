class virtualenv($env_name="virtualenv", $path="/home/vagrant") {
    exec { "virtualenv ${env_name}":
        cwd => $path,
        path => ["/usr/bin"],
        creates => "${path}/${name}",
        require => Class["virtualenv::install"]
    }

    include virtualenv::install
}
