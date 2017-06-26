variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
}

variable "key_path" {
    description = "Path to the private portion of the SSH key specified."
}

variable "aws_region" {
    description = "AWS region to launch servers."
}

variable "aws_access_key" {
    description = "AWS access_key"
}


variable "aws_secret_key" {
    description = "AWS Secret Key"
}

variable "subnet_id" {
    description = "Subnet ID to use in VPC"
}

variable "instance_type" {
    description = "Instance type"
}

variable "instance_name" {
    description = "Instance Name"
}

variable "ebs_size" {
    description = "size of the ebs volume required"
}

variable "snapshot_id" {
    description = "Snapshot ID of AWS public dataset"
}

variable "bucket_name" {
    description = "e.g. your-bucket-name"
        
}

variable "ami_id" {
    description = "ami id"
}
