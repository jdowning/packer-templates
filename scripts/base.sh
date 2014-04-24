echo "deb http://archive.ubuntu.com/ubuntu precise multiverse" >/etc/apt/sources.list.d/multiverse.list
aptitude -y update
aptitude install -y build-essential make openssl libreadline-dev gcc zlib1g-dev libssl-dev libreadline-gplv2-dev libyaml-dev
aptitude install -y linux-headers-$(uname -r) vim curl git nfs-common

echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | debconf-set-selections
aptitude install -y iptables-persistent

# Set up sudo
( cat <<'EOP'
%vagrant ALL=NOPASSWD:ALL
EOP
) > /tmp/vagrant
chmod 0440 /tmp/vagrant
mv /tmp/vagrant /etc/sudoers.d/

echo "UseDNS no" >> /etc/ssh/sshd_config
