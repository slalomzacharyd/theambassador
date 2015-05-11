FROM centos
MAINTAINER Zachary Dovel <zacharyd@slalom.com>

LABEL Description="This image is used to start the foobar executable" Vendor="ACME Products" Version="1.0"


RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum install puppet tar -y

ADD ["vagrant/puppet/", "/tmp/puppet"]
ADD ["config/", "/etc/puppet/hieradata/"]
ADD ["vagrant/hiera.yaml", "/etc/puppet/"]
ADD ["vagrant/hiera.yaml", "/etc/puppet/"]

RUN puppet module install puppetlabs-stdlib
RUN puppet module install puppetlabs-mysql
RUN puppet module install ajcrowe-supervisord

ENV HOSTNAME="theambassador"
ENV FACTER_hostname="theambassador"

RUN  cd /etc/puppet && puppet apply --hiera_config /etc/puppet/hiera.yaml --modulepath=/tmp/puppet/modules:/etc/puppet/modules /tmp/puppet/manifests/default.pp --verbose --debug

EXPOSE 8080
EXPOSE 9000
