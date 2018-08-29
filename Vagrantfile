 Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "vpro_app", "/root"
  config.vm.network 'public_network'

############################################ INSTALLING CI SERVER ###############################################################################
  config.vm.define "ci" do |build|
   build.vm.hostname = 'build01.com'
   build.vm.network "private_network", ip: "192.168.10.10"
   build.vm.provision :shell, inline: <<-SHELL
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes'/ /etc/ssh/sshd_config
   cd /root
   ./ciserver.sh
   SHELL
  end

############################################ INSTALLING APP SERVER #######################################################################
   config.vm.define "app" do |app|
   app.vm.hostname = 'app01.com'
   app.vm.network "private_network", ip: "192.168.10.11"
   app.vm.provision :shell, inline: <<-SHELL
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes'/ /etc/ssh/sshd_config
   cd /root
   ./appserver.sh
   SHELL
  end

####################################### DB SERVER ##########################################################################################
   config.vm.define "db" do |db|
   db.vm.hostname = 'db01.com'
   db.vm.network "private_network", ip: "192.168.10.12"
   db.vm.provision :shell, inline: <<-SHELL
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes'/ /etc/ssh/sshd_config
   cd /root
   ./mysql.sh
   SHELL
 end
##################################### LOAD-BALANCER server ###############################################################################
   config.vm.define "lb" do |lb|
   lb.vm.hostname = 'lb01.com'
   lb.vm.network "private_network", ip: "192.168.10.13"
   lb.vm.provision :shell, inline: <<-SHELL
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes'/ /etc/ssh/sshd_config
   cd /root
   ./lb.sh   
   SHELL
 end


###################################### MEMCACHE SERVER ###################################################################################

   config.vm.define "mem" do |mem|
   mem.vm.hostname = 'memchahe01.com'
   mem.vm.network "private_network", ip: "192.168.10.14"
   mem.vm.provision :shell, inline: <<-SHELL
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes'/ /etc/ssh/sshd_config
   cd /root
   ./mem.sh
   SHELL
end


############################################## RABBITMQ-SERVER ###############################################################################

   config.vm.define "rmq" do |rmq|
   rmq.vm.hostname = 'rmq01.com'
   rmq.vm.network "private_network", ip: "192.168.10.15"
   rmq.vm.provision :shell, inline: <<-SHELL
   sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes'/ /etc/ssh/sshd_config
   cd /root
   ./rmq.sh
   SHELL
 end

end
