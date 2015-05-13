# Kegbot Server

This is Kegbot Server, a backend and web interface for monitoring
and managing kegged beverages.

**Official repository:** https://github.com/Kegbot/kegbot-server/


## Quick start

Super quick start instructions for development (using vagrant and virtualbox):

```
$ pacman -S virtualbox      # Install virtualbox from https://www.virtualbox.org/
$ pacman -S vagrant         # Install vagrant from https://www.vagrantup.com/
$ pacman -S git             # Install git
$ git clone https://github.com/slalomzacharyd/theambassador.git  # Clone the repository
$ cd theambassador          # cd into the repository's directory
$ cp -r config ../          # Make a copy of the default config outside of the repository
$ vim ../config/common.json # Edit the config to remove the default passwords and such
$ vagrant up                # Start vagrant to provision kegbot
$ firefox localhost:8080    # Load the kegbot web ui!

```

Super quick start instructions for a docker app :

```
$ pacman -S docker          # Install docker
$ systemctl start docker; systemctl enable docker;  # Start the docker service and enable it for future boots
$ pacman -S git             # Install git
$ git clone https://github.com/slalomzacharyd/theambassador.git  #Clone the repository
$ cd theambassador          # cd into the repository's directory
$ cp -r config ../          # Make a copy of the default config outside of the repository
$ vim ../config/common.json # Edit the config to remove the default passwords and such
$ ruby docker/setup.rb      # Build the kegbot docker image
$ systemctl start kegbot-theambassador  # Start the webserver
$ firefox localhost:8080   #Load the kegbot web ui!

```

For much more detail, see the complete [Kegbot Server documentation](http://kegbot.org/docs/server/).


## Documentation and Help

Please see our main website, http://kegbot.org/, for
[documentation](http://kegbot.org/docs), the
[Kegbot Forum](http://kegbot.org/kegbb/), and the
[Kegbot Blog](http://kegbot.org/blog/).

You can also find us on **#kegbot** on freenode IRC.

You should definitely follow [@kegbot](http://twitter.com/kegbot) on
Twitter, all the cool kids are.


## Related Projects

* [Kegboard](https://github.com/Kegbot/kegboard): Firmware and schematics
  for the Kegbot controller board.
* [Kegbot Android app](https://github.com/Kegbot/kegbot-android): Kegtap,
  the Kegbot manager app for Android.


## License and Copyright

This software is offered under the **GPLv2** license.  Your use of
Kegbot Server constitutes your agreement to that license.  Please see
``LICENSE.txt`` for the full license.

Code and documentation are **Copyright 2014 Bevbot LLC**,
unless otherwise noted.  Graphics and images distributed with Kegbot,
such as the Kegbot logo, are also copyrighted works of Bevbot LLC
unless otherwise noted, and may not be reused without permission.


## Contributing

We love getting patches! Send us a pull request, or hop on to IRC if
you'd like to chat about something substantial.

[![Build Status](https://travis-ci.org/Kegbot/kegbot-server.png?branch=master)](https://travis-ci.org/Kegbot/kegbot-server)

