#!/bin/bash

hostname theambassador
echo "theambassador" > /etc/hostname
sed -i 's/Defaults    requiretty/Defaults    !requiretty/' /etc/sudoers

