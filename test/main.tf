provider "aws" {
    region = "us-east-2"


    assume_role {
    role_arn = "arn:aws:iam::907143134003:role/TerraformStateAccessRole"
  }
}
terraform {
  

  backend "s3" {    
    bucket = "terraform-states-prod1"
    key    = "test-eks/terraform.tfstate"
    region = "us-east-2"

    role_arn = "arn:aws:iam::907143134003:role/TerraformStateAccessRole"
  }

}


