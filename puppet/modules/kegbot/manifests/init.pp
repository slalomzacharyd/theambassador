class kegbot ($applications = hiera('applications')) {
    class {'kegbot::config':
        applications => $applications,
        require => Class['kegbot::install']
    }
    contain 'kegbot::config'
    class {'kegbot::install':
        applications => $applications,
        require => Class['db'],
    }
    contain 'kegbot::install'
}
