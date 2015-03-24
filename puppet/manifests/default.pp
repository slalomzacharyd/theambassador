
node default {
    include networking, login, vimenhanced, redis, db


#    dbdatabase {'kegbot':
#        dbpath
#        provider => mariadbdatabase
#    }
#
#    dbuser {'kegbot':
#        dbpath
#        provider => mariadbuser
#    }
#     class {"kegbot":
#         path => "/home/vagrant",
#         user => "vagrant",
#         env_name => "kegbot",
#     }
}



