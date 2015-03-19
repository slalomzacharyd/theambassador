class vimEnhanced::install {
    package {"vim-enhanced":
        ensure => latest,
        allow_virtual => false,
    }
}
