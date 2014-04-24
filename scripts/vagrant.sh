date > /etc/vagrant_box_build_time

# Installing vagrant keys
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

# color prompt
echo 'export PS1="\[\e[0;32m\]\u@\h:\w\\$ \[\e[m\]"' >> /home/vagrant/.bashrc

# Install the VirtualBox guest additions
if [ -f /home/vagrant/.vbox_version ]; then
    mkdir /tmp/vbox
    VER=$(cat /home/vagrant/.vbox_version)
    mount -o loop VBoxGuestAdditions_$VER.iso /tmp/vbox 
    sh /tmp/vbox/VBoxLinuxAdditions.run
    umount /tmp/vbox
    rmdir /tmp/vbox
    rm *.iso
    ln -s /opt/VBoxGuestAdditions-$VER/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
fi

# Install the VMWare guest additions
if [ -f /home/vagrant/.vmfusion_version ]; then
    home_dir="/home/vagrant"
    iso_name="linux.iso"
    mount_point="/tmp/vmware-tools"
    mkdir ${mount_point}
    cd ${home_dir}
    mount -o loop ${iso_name} ${mount_point}
    tar zxf ${mount_point}/VMWareTools*.tar.gz
    ${mount_point}/vmware-tools-distrib/vmware-install.pl --default
    umount ${mount_point}
    rm -rf ${home_dir}/${iso_name} ${home_dir}/vmware-tools-distrib
    rmdir ${mount_point}
fi
