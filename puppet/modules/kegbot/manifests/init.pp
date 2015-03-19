class kegbot ($path, $env_name, $user) {
    include kegbot::config
    class {'kegbot::install':
        path => $path,
        env_name => $env_name,
        user => $user
    }
}
