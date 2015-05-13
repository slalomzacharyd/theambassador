#!/usr/bin/env ruby

require "json"
require "erb"

cwd = File.expand_path File.dirname(__FILE__)
Dir.chdir('..')
build_dir = File.basename(Dir.pwd)
Dir.chdir('..')


config = JSON.parse(File.read("#{cwd}/../../config/common.json"))

server_name = config["networking::hostname"]
server_port = config['applications']['kegbot']['access_rules']['http']['port']

dockerfile_template = ERB.new(File.read("#{cwd}/Dockerfile.erb"))
dockerfile = dockerfile_template.result()

#Create the docker image
File.write("Dockerfile-#{server_name}.tmp", dockerfile)
#system "sudo docker build --no-cache -f Dockerfile-#{server_name}.tmp -t kegbot/#{server_name} ."
File.delete("Dockerfile-#{server_name}.tmp")

Dir.chdir(cwd)

#Create the init script
service_template = ERB.new(File.read('kegbot.service.erb'))
service = service_template.result()
File.write("/usr/lib/systemd/system/kegbot-#{server_name}.service", service)

script_template = ERB.new(File.read('kegbot.prescript.erb'))
script = script_template.result()
File.write("/usr/lib/systemd/scripts/kegbot-#{server_name}-prestart", script)
File.chmod(0755, "/usr/lib/systemd/scripts/kegbot-#{server_name}-prestart")
