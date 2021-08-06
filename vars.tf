variable "AWS_REGION" {
    default = "us-east-1"
}

###############################
# ADDING AMI VARIABLES
###############################

variable "AMI" {
    type = map(string)
    
    default = {
        us-east-1 = "ami-0133407e358cc1af0"
    }
}

###############################
# CREATE EC2
###############################

resource "aws_instance" "babs-web" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    tags = {
          Name = "babs-web"
     }

    # VPC
    subnet_id = "${aws_subnet.habeeb-subnet-public-1.id}"
    
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]

    # the Public SSH key
    key_name = "${aws_key_pair.mykey.key_name}"



    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
        host = "self.public_ip"
    }
}
// Sends your public key to the instance
//resource "aws_key_pair" "mykey" {
//    key_name = "mykey.pub"
//    public_key = "${file(var.PUBLIC_KEY_PATH)}"



variable "EC2_USER" {
  default = "ec2-user"
}




variable "PRIVATE_KEY_PATH" {
  default = "mykey"

}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}
