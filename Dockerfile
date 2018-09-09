FROM chef/chefdk
ADD solo_config/solo.rb /etc/chef/solo.rb
WORKDIR /var/chef/cookbooks
