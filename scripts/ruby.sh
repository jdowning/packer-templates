# Install Ruby from source in /opt so that users of Vagrant
# can install their own Rubies using packages or however.

RUBY_VERSION=2.1.1
wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-$RUBY_VERSION.tar.gz
tar xvzf ruby-$RUBY_VERSION.tar.gz
cd ruby-$RUBY_VERSION
CFLAGS="-O3" ./configure --prefix=/opt/ruby
CFLAGS="-O3" make
CFLAGS="-O3" make install
cd ..
rm -rf ruby-$RUBY_VERSION

# Add /opt/ruby/bin to the global path as the last resort so
# Ruby, RubyGems, and Chef/Puppet are visible
echo 'PATH=$PATH:/opt/ruby/bin/'> /etc/profile.d/vagrantruby.sh
