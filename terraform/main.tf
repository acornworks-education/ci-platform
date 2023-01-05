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

resource "aws_db_instance" "test_db" {
    allocated_storage = 50    
    identifier = "testdb"
    storage_type = "gp2"
    engine = "postgresql"
    instance_class = "db.t2.medium"
    username = "admin"
    password = "P@ssw0rd"
    publicly_accessible = true
    db_subnet_group_name = aws_db_subnet_group.db-subnet.name
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private-db-subnet-se2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-southeast-2"
}

resource "aws_subnet" "private-db-subnet-ne2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-northeast-2"
}

resource "aws_db_subnet_group" "db-subnet" {
    name = "db_subnet_group"
    subnet_ids = [aws_subnet.private-db-subnet-se2.id, aws_subnet.private-db-subnet-ne2.id]
}