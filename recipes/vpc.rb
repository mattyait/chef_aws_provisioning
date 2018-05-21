#
# Cookbook:: aws_provisioning
# Recipe:: vpc
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
require 'chef/provisioning/aws_driver'
with_driver 'aws:' + node['chef_aws_provisioning']['aws']['profile'] + ':' + node['chef_aws_provisioning']['vpc']['aws_region']

aws_vpc node['chef_aws_provisioning']['vpc']['vpc_name'] do
  cidr_block node['chef_aws_provisioning']['vpc']['cidr_block']
  internet_gateway true
  instance_tenancy :default
  enable_dns_support true
  enable_dns_hostnames true
  aws_tags :chef_type => 'aws_vpc'
end
