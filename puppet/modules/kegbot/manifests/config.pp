class kegbot::config ($applications) {
    $names = keys($applications)
    define createConfigurations($applications) {
        mysql_database { 'kegbot':
            ensure => present,
            charset => 'utf8',
        }
    }
    createConfigurations{$names:
        applications => $applications
    }
#
#
#    mysql_grant {
#        ensure     => 'present',
#        options    => ['GRANT'],
#        privileges => ['ALL'],
#        table      => 'kegbot.*',
#        user       => 'ketbot@localhost',
#    }
}
