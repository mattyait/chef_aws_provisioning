FROM chef/chefdk
RUN apt-get update -y
RUN apt-get install awscli -y
ADD solo_config/solo.rb /etc/chef/solo.rb
WORKDIR /var/chef/cookbooks
