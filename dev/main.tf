provider "aws" {
    region = "us-east-1"
}
terraform {
  

  backend "s3" {    
    bucket = "terraform-states-prod1"
    key    = "dev-eks/terraform.tfstate"
    region = "us-east-1"

    role_arn = "arn:aws:iam::907143134003:role/TerraformStateAccessRole"
  }

}


