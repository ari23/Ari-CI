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
