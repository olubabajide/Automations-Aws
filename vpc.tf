#####################
# VPC
#####################

resource "aws_vpc" "habeeb-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #give you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
        Name = "habeeb-vpc"
    }
}

###################
# PUBLIC SUBNET
###################

resource "aws_subnet" "habeeb-subnet-public-1" {
    vpc_id = "${aws_vpc.habeeb-vpc.id}"
    cidr_block = "10.0.14.0/24"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "us-east-1a"

    tags = {
        Name = "habeeb-subnet-public-1" 
    }
}

#####################
# PRIVATE SUBNET
#####################

resource "aws_subnet" "habeeb-subnet-private-1" {
    vpc_id = "${aws_vpc.habeeb-vpc.id}"
    cidr_block = "10.0.19.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "habeeb-subnet-private-1" 
    }

}
