class kegbot ($applications = hiera('applications')) {
    class {'kegbot::config':
        applications => $applications,
        require => Class['kegbot::install']
    }
    class {'kegbot::install':
        applications => $applications,
        require => Class['db'],
    }
}
