
class db::service {
#     service { "stop-mariadb-for-maintenance":
#         name => "mariadb",
#         ensure => stopped,
#         require => Class["mariadb::service"]
#     }
#     
#     exec { "mysql_install_db --user=mysql":
#         path => ["/bin", "/usr/bin"],
#         notify => Service["mariadb"],
#         require => Service["stop-mariadb-for-maintenance"]
#     }
# 
#     service { "mariadb":
#         ensure => running,
#         hasstatus => true,
#         hasrestart => true,
#         enable => true,
#         require => Exec["mysql_install_db --user=mysql"],
#     }
}
