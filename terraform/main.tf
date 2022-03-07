terraform {  
  required_providers {    
    aws = {      
      source  = "hashicorp/aws"      
      version = "~> 3.27"
    }  
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region = local.region
}

locals {
  region          = "eu-central-1"
  tags = {
    Owner         = "FIX ME"
    Purpose       = "Presentation"
    Deployment    = "Terraform"
  }
}
