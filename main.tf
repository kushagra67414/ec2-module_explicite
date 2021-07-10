// Terraform S3 Backend for Remote State Management
terraform {
  backend "s3" {
    bucket = "kushagrabucketdevops"
    key = "key-name.tfstate"
    region = "ap-south-1"
    dynamodb_table = "dynamo-lock"
  }
}

// Getting User Data File
data "local_file" "user_data_file" {
  filename = var.user_data_filename
}

// Getting Role Policy File
data "local_file" "policy_file" {
  filename = var.role_policy_filename
}

// Importing ec2 Module
module "ec2" {
  source = "./modules/ec2/"
  ami_id = var.ami_id
  sg_ingress = var.sg_ingress
  user_data = data.local_file.user_data_file.content
  ec2_role_policy = data.local_file.policy_file.content
}
