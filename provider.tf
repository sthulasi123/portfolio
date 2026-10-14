provider "aws" {

  region = "ap-south-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr-vpc
  enable_dns_support = true
  enable_dns_hostnames = true
  tags={
    Name=var.vpc-name
  }
}

resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
    cidr_block = var.cidr-subnet1
    availability_zone = "ap-south-1a"
    tags={
      Name=var.subnet1-name
    }
  }

resource "aws_subnet" "mysubnet2" {
  vpc_id     = aws_vpc.myvpc.id
    cidr_block = var.cidr-subnet2
    availability_zone = "ap-south-1b"
    tags={
      Name=var.subnet2-name
    }
}