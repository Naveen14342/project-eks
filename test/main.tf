provider "aws" {
    region = "us-east-2"
    }
terraform {
  

  backend "s3" {    
    bucket = "terraform-states-prod1"
    key    = "test-eks/terraform.tfstate"
    region = "us-east-1"

    role_arn = "arn:aws:iam::907143134003:role/TerraformStateAccessRole"
  }

}


