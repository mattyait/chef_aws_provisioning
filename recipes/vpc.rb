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
  cidr_block node['chef_aws_provisioning']['vpc']['public_cidr_block1']
  availability_zone node['chef_aws_provisioning']['vpc']['vpc_az_1']
  map_public_ip_on_launch false
  route_table public_route_table
end

public_subnet_2 = aws_subnet "public-subnet-2-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  vpc lazy { my_vpc.aws_object.id }
  cidr_block node['chef_aws_provisioning']['vpc']['public_cidr_block2']
  availability_zone node['chef_aws_provisioning']['vpc']['vpc_az_2']
  map_public_ip_on_launch false
  route_table public_route_table
end

eip1 = aws_eip_address 'nat1-elastic-ip'

nat1 = aws_nat_gateway 'nat-gateway-1' do
  subnet lazy { public_subnet_1.aws_object.id }
  eip_address lazy { eip1.aws_object.public_ip }
end

private_route_table_1 = aws_route_table "private-route-table1-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  routes '0.0.0.0/0' => "#{nat1.aws_object.nat_gateway_id}"
  vpc lazy { my_vpc.aws_object.id }
end

private_subnet_1 = aws_subnet "private-subnet-1-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  vpc lazy { my_vpc.aws_object.id }
  cidr_block node['chef_aws_provisioning']['vpc']['private_cidr_block1']
  availability_zone node['chef_aws_provisioning']['vpc']['vpc_az_1']
  map_public_ip_on_launch false
  route_table private_route_table_1
end

eip2 = aws_eip_address 'nat2-elastic-ip'

nat2 = aws_nat_gateway 'nat-gateway-2' do
  subnet lazy { public_subnet_2.aws_object.id }
  eip_address lazy { eip2.aws_object.public_ip }
end

private_route_table_2 = aws_route_table "private-route-table2-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  routes '0.0.0.0/0' => "#{nat2.aws_object.nat_gateway_id}"
  vpc lazy { my_vpc.aws_object.id }
end

private_subnet_2 = aws_subnet "private-subnet-2-#{node['chef_aws_provisioning']['vpc']['vpc_name']}" do
  vpc lazy { my_vpc.aws_object.id }
  cidr_block node['chef_aws_provisioning']['vpc']['private_cidr_block2']
  availability_zone node['chef_aws_provisioning']['vpc']['vpc_az_2']
  map_public_ip_on_launch false
  route_table private_route_table_2
end
