#
# Cookbook:: aws_provisioning
# Recipe:: vpc
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#
require 'chef/provisioning/aws_driver'
with_driver 'aws:' + node['chef_aws_provisioning']['vpc']['profile'] + ':' + node['chef_aws_provisioning']['vpc']['aws_region']

my_vpc = aws_vpc node['chef_aws_provisioning']['vpc']['vpc_name'] do
  cidr_block node['chef_aws_provisioning']['vpc']['cidr_block']
  internet_gateway true
  instance_tenancy :default
  enable_dns_support true
  enable_dns_hostnames true
  aws_tags :chef_type => 'aws_vpc'
end

public_route_table = aws_route_table "public-route-table-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  vpc lazy { my_vpc.aws_object.id }
  routes '0.0.0.0/0' => :internet_gateway
  aws_tags chef_type: 'aws_route_table'
end

public_subnet_1 = aws_subnet "public-subnet-1-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  vpc lazy { my_vpc.aws_object.id }
  cidr_block node['chef_aws_provisioning']['vpc']['cidr_block1']
  availability_zone node['chef_aws_provisioning']['vpc']['vpc_az_1']
  map_public_ip_on_launch false
  route_table public_route_table
end

public_subnet_2 = aws_subnet "public-subnet-2-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  vpc lazy { my_vpc.aws_object.id }
  cidr_block node['chef_aws_provisioning']['vpc']['cidr_block2']
  availability_zone node['chef_aws_provisioning']['vpc']['vpc_az_2']
  map_public_ip_on_launch false
  route_table public_route_table
end
