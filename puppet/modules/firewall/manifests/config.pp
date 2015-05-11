class firewall::config($applications = hiera_hash("applications")) {
    $applications_merged = merge($applications, {
        'core' => {
            'access_rules' => {
                'ssh' => {
                    'port' => 22,
                    'protocol' => "tcp"
                }
            }
        }
    })
    $applicationnames = keys($applications_merged)

    file {'/etc/firewalld/zones/development.xml':
        ensure => file,
        content => template('firewall/development.xml.erb'),
        owner => 'root',
        group => 'root',
        mode => '0600',
        notify => Class['firewall::service'],
        require => Class['firewall::install']
    }

    define createApplicationRules($applications) {
        $applicationname = $name
        $application = $applications[$name]
        $rules = $application["access_rules"]
        
        file {"/etc/firewalld/services/${name}.xml":
            ensure => file,
            content => template('firewall/application.xml.erb'),
            owner => 'root',
            group => 'root',
            mode => '0600',
            notify => Class['firewall::service'],
            require => Class['firewall::install']
        }
    }

    file {'/etc/firewalld/firewalld.conf':
        ensure => file,
        content => template('firewall/firewalld.conf.erb'),
        owner => 'root',
        group => 'root',
        mode => '0600',
        notify => Class['firewall::service'],
        require => Class['firewall::install']
    }

    createApplicationRules{$applicationnames:
        applications => $applications_merged
    }

}
