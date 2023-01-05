terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }

    backend "s3" {
        bucket = "acornworks-terraform-state-f00d3247"
        key = "terraform.tfstate"
        region = "ap-southeast-2"
    }
}

provider "aws" {
    access_key = "AKIAY6G42Q4CBIEVLBMY"
    secret_key = "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"
    region = "ap-southeast-2"

    assume_role {
      role_arn = "arn:aws:iam::614643435268:role/ci-provisioning-role"
    }
}

resource "aws_s3_bucket" "terraform-state" {
    bucket = "acornworks-terraform-state-f00d3247"

    tags = {
      "service" = "platform"
      "org" = "acornworks"
    }
}