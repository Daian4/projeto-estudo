terraform {
    required_version = ">=1.10.4"
    required_providers {
        aws = ">=5.90.1"
        local = ">=2.5.2"
  }
}

provider "aws" {
    region = "us-east-1"
}