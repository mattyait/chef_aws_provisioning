# chef_aws_provisioning

Chef cookbooks to provision the infrastrucure on AWS Cloud

Build the docker image

`docker build -t chef/chefdk:v1 .`

Run the docker container

`docker run -i -d -v ~/Documents/workstation/chef_aws_provisioning:/var/chef/cookbooks chef/chefdk:v1`
