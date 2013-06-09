dnsmasq::conf { 'another-config':
    ensure  => present,
    content => "dhcp-range=172.16.129.100,172.16.129.150,12h\ndhcp-boot=pxelinux.0\ndhcp-option=3,172.16.129.2\ndhcp-option=6,192.168.72.10\ndomain=localdomain\nexpand-hosts\ndhcp-host=master.localdomain,172.16.129.10\ndhcp-option=6,8.8.8.8",
}
