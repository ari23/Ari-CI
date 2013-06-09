wet http://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update
apt-get install puppet
apt-get install puppetmaster


puppet resource service puppet ensure=running enable=true
puppet resource service puppetmaster ensure=running enable=true


puppet module install puppetlabs-razor

chown -R puppet:puppet /etc/puppet/modules

puppet apply /etc/puppet/modules/razor/tests/init.pp --verbose

echo "ari ALL=(ALL) ALL" > /etc/sudoers.d/20_ari
chmod 440 /etc/sudoers.d/20_ari


puppet module install saz-dnsmasq

puppet apply /etc/puppet/modules/dnsmasq/tests/init.pp --verbose

create a dnsmasq.pp in dnsmasq module..
dnsmasq::conf { 'another-config':
    ensure  => present,
          content => "dhcp-range=192.168.72.100,192.168.72.150,12h\ndhcp-boot=pxelinux.0\ndhcp-option=3,192.168.72.2\ndhcp-option=6,8.8.8.8",
}

puppet apply dnsmasq.pp

to force start tftp:
/etc/puppet/modules/tftp
puppet apply init.pp


/opt/razor/bin/razor_daemon.rb status --- If this fails, then do gem install net-scp
/opt/razor/bin/razor_daemon.rb start
export PATH=$PATH:/opt/razor/bin

To add microkernel:
wget https://github.com/puppetlabs/Razor-Microkernel/downloads/rz_mk_dev-image.0.9.3.0.iso
razor image add --type mk --path ./rz_mk_dev-image.0.9.3.0.iso 

razor image add --type os --path /home/ari/Ari-CI/ubuntu-12.04.2.2-server-amd64.iso --name ubuntu_precise--version 12.04

razor model add --template=ubuntu_precise --label=install_precise --image-uuid=3ESbDrx9WgRrzrieM6P1Ye

razor policy add --template=ubuntu_precise --label=precise --model-uuid=73uSftowi7rQNnrPiz3ce0 --tags=cpus_1,memsize_1GiB,vmware_vm,nics_2 --enabled true

razor tag 7lCMf40wZVgxaQhwSQEnFg matcher add --key=mk_hw_disk_count --compare=eq│razor image add --type os --path /home/ari/Ari-CI/ubuntu-12.04.2.2-server-amd64.iso --name ubuntu_pre
ual --value=1 


razor policy update 3uRNkcz0Kt9Mls3Ekcqu1Y --tags onlyonedisk,cpus_1,vmware_vm,m│razor image add --type os --path /home/ari/Ari-CI/ubuntu-12.04.2.2-server-amd64.iso --name ubuntu_pre
emsize_1GiB,nics_2

razor broker add --plugin=master.localdomain --name=puppetmaster --description="Puppet Master" servers=master.localdomain

razor policy update 3uRNkcz0Kt9Mls3Ekcqu1Y --broker-uuid 307budHWX3Yn7nD2R2dcfo

Change the os_boot.erb in /opt/razor/lib/project_razor/model/ubuntu/precise/ 
with "echo 172.16.129.10  master.localdomain  master"
 


