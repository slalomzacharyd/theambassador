

node theambassador {
    if $virtual == 'docker' {
        hiera_include("classes::docker")
    }
    else {
        hiera_include('classes::vm')
    }
}
