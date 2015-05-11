class vimenhanced {
    contain vimenhanced::install, vimenhanced::config
}

Class['vimenhanced::install'] -> Class['vimenhanced::config']
