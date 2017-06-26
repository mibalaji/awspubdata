# awspubdata
Copying AWS public dataset from EBS snapshot to S3 bucket using Terraform

Need the following tools for running the terraform automation script:

1) Terraform (https://www.terraform.io/intro/getting-started/install.html)

2) aws cli and configure it with the access key and secret

3) ansible

Settings such as AWS Access/Secret keys, ami id, etc can be configured inside variables.tf file

create a credentials file in the directory where the main.tf & variables.tf files are located with the AWS Access/Secret keys in the file named  "credentials".

Invoke terraform to create an ec2-instance, EBS volume from the sample data snapshot, Create S3 bucket and copy the data across automatically:

  $terraform plan

  $terraform apply

