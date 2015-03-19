class vimenhanced {
    include vimenhanced::install, vimenhanced::config
}

Class['vimenhanced::install'] -> Class['vimenhanced::config']
