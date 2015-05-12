FROM centos:7
MAINTAINER Zachary Dovel <zacharyd@slalom.com>

LABEL Description="This image is used to start the foobar executable" Vendor="ACME Products" Version="1.0"


RUN rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum install puppet tar git -y

ADD ["vagrant/puppet/", "/tmp/puppet"]
ADD ["config/", "/etc/puppet/hieradata/"]
ADD ["vagrant/hiera.yaml", "/etc/puppet/"]
ADD ["vagrant/hiera.yaml", "/etc/puppet/"]

RUN puppet module install puppetlabs-concat
RUN puppet module install puppetlabs-stdlib

RUN if [ ! -d '/etc/puppet/modules/mysql' ]; then git clone https://github.com/slalomzacharyd/puppet-supervisord.git /etc/puppet/modules/supervisord; fi
RUN if [ ! -d '/etc/puppet/modules/mysql' ]; then git clone https://github.com/slalomzacharyd/puppetlabs-mysql.git /etc/puppet/modules/mysql; fi

ENV HOSTNAME="theambassador"
ENV FACTER_hostname="theambassador"
ENV FACTER_virtual="docker"

RUN  cd /etc/puppet && puppet apply --hiera_config /etc/puppet/hiera.yaml --modulepath=/tmp/puppet/modules:/etc/puppet/modules /tmp/puppet/manifests/default.pp --verbose --debug

RUN rm -rf /var/run/supervisord.pid
RUN rm -rf /var/run/nginx.pid
RUN rm -rf /tmp/kegbot_run_workers.pid

VOLUME /var/lib/mysql

EXPOSE 8080