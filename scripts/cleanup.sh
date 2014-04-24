# Remove items used for building, since they aren't needed anymore
apt-get -y remove linux-headers-*
apt-get -y autoremove
apt-get -y clean
aptitude clean
aptitude autoclean

#Clean up tmp
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
rm -rf /tmp/*

# more clean up
[ -f /home/ubuntu/.ssh/authorized_keys ] && rm /home/ubuntu/.ssh/authorized_keys
find /var/log -type f | while read f; do echo -ne '' > $f; done
unset HISTFILE
[ -f /root/.bash_history ] && rm /root/.bash_history
[ -f /home/ubuntu/.bash_history ] && rm /home/ubuntu/.bash_history

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces

# update /etc/hosts
cat <<EOF > /etc/hosts
127.0.0.1    trusty64 localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF
