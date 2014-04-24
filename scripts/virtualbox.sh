# Install the VirtualBox guest additions
mkdir /tmp/vbox
VER=$(cat /home/vagrant/.vbox_version)
mount -o loop VBoxGuestAdditions_$VER.iso /tmp/vbox 
sh /tmp/vbox/VBoxLinuxAdditions.run
umount /tmp/vbox
rmdir /tmp/vbox
rm *.iso
ln -s /opt/VBoxGuestAdditions-$VER/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
