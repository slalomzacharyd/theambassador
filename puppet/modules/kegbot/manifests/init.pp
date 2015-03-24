class kegbot ($applications) {
    class {'kegbot::install':
        applications => $applications
    }
}
