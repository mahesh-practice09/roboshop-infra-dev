terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
  }
  backend "s3" {
      region = "us-east-1"
      bucket = "roboshop-infra-sbx"
      key = "roboshop-infra-sbx-databases.tfstate"
      encrypt = true 
      use_lockfile = true
  }

}

provider "aws" {
  region = "us-east-1"
}