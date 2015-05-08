class vimenhanced::config ($path = '/home/vagrant', $owner = 'vagrant', $group = 'vagrant') {
    file {"${path}/.vimrc":
        owner => $owner,
        group => $group,
        ensure => file,
        content => template("vimenhanced/vimrc.erb"),
        require => Class['login'],
    }
}
