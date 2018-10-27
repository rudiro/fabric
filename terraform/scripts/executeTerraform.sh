#!/bin/bash


cd /aws/deployment/terraform

#export TF_LOG=TRACE
rm terraform.tfstate
rm ./tmp/*.txt
rm /Users/rudiro/.ssh/known_hosts

echo "Start terraform init"
terraform init

echo "Import existing vpc "
#terraform import -var-file=./configs/GET_DEV_variables.tfvars  aws_vpc.vpc vpc-06c4b8f48f75073e1
terraform import -var-file=$4  aws_vpc.fabric-vpc $1


echo "Start terraform apply"
terraform apply -input=false -auto-approve -var aws_access_key=$2 -var aws_secret_key=$3 -var-file=$4




#echo "Start ansible playbook"
#rm ../ansible/terraform.tfstate
#cp terraform.tfstate ../ansible/.
#cd ../ansible

#ansible-playbook --inventory `which terraform-inventory` ../ansible/deploy.yaml
#ansible-playbook --inventory /go/bin/terraform-inventory deploy.yaml