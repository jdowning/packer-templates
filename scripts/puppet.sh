# Prepare puppetlabs repo
wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
rm puppetlabs-release-trusty.deb

# Install puppet/facter
aptitude update
aptitude install -y puppet facter
