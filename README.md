# chef_aws_provisioning

Chef cookbooks to provision the infrastrucure on AWS Cloud

Build the docker image

    docker build -t chef/chefdk:v1 .

Run the docker container

    docker run -i -d -v ~/Documents/workstation/:/var/chef/cookbooks chef/chefdk:v1

Login to container in interactive mode

    docker exec -it <container_id> "/bin/bash"

Setup the AWS profile

    aws configure
    AWS Access Key ID [None]: *********
    AWS Secret Access Key [None]: **********
    Default region name [None]:
    Default output format [Noµne]:
    Run the chef recipe

Run the recipe

    chef-solo -c solo_config/solo.rb -o "recipe[chef_aws_provisioning::vpc]"
