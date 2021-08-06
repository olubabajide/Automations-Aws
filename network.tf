####################
# INTERNET GATE WAY
####################

resource "aws_internet_gateway" "habeeb-igw" {
    vpc_id = "${aws_vpc.habeeb-vpc.id}"
    tags = {
        Name = "habeeb-igw"
    }
}

##########################
# CUSTOM ROUTE TABLE (CRT)
##########################

resource "aws_route_table" "habeeb-public-crt" {
    vpc_id = "${aws_vpc.habeeb-vpc.id}"

    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"

        //CRT uses this IGW to reach the INTERNET
        gateway_id = "${aws_internet_gateway.habeeb-igw.id}"
        
    }

    tags = {
        Name = "habeeb-public-crt"
    }
}

################################
# ASSOCIATE YOUR CRT AND SUBNET
################################

resource "aws_route_table_association" "habeeb-crta-public-subnet-1" {
    subnet_id = "${aws_subnet.habeeb-subnet-public-1.id}"
    route_table_id = "${aws_route_table.habeeb-public-crt.id}"
}

#############################
# SECURITY GROUP
#############################

resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.habeeb-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
    // I will be installing NGINX, that's why am opening port 80.
    // If you do not add this rule, you can not reach the NGIX. 
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "ssh-allowed"
    }
}

