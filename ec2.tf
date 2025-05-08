#Version 1 — Without Variables (Hardcoded values)..
#key-pair login
resource aws_key_pair my_key {
  key_name = "terra-key-ec2"
  public_key = file("id_ed25519.pub") #in file function pass paramete file name public key of SSH
}
#VPC & Security Group
resource "aws_default_vpc" "default" {
  
}
resource "aws_security_group" "my_security_group" {
  name = "automate-sg"
  description = "this will add Tf genrated security group"
  vpc_id = aws_default_vpc.default.id #interpolation
#inbound
ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "SSH open"
}
ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "HTTP open"
}
#outbound
egress {
  from_port = 0
  to_port =  0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  description = "all accesss open outbound"
}
  tags = {
    Name ="automate-sg"
  }
}
#AWS_EC2_instance
resource "aws_instance" "my_instance" {
 key_name = aws_key_pair.my_key.key_name
 security_groups = [aws_security_group.my_security_group.name] 
 instance_type = "t2.micro"
 ami = "ami-058a8a5ab36292159" #ubuntu

 root_block_device {
   volume_size = 8
   volume_type = "gp3"
 }
 tags ={
  Name = "my first terra instance"
 }
}





#Version 2 — With Variables (Dynamic values)
#code when terrafrom variable declares pre defined value and DNS , pubic IP and Private IP
#key-pair login
resource aws_key_pair my_key {
  key_name = "terra-key-ec2"
  public_key = file("id_ed25519.pub") #in file function pass paramete file name public key of SSH
}
#VPC & Security Group
resource "aws_default_vpc" "default" {
  
}
resource "aws_security_group" "my_security_group" {
  name = "automate-sg"
  description = "this will add Tf genrated security group"
  vpc_id = aws_default_vpc.default.id #interpolation
#inbound
ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "SSH open"
}
ingress {
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "HTTP open"
}
#outbound
egress {
  from_port = 0
  to_port =  0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  description = "all accesss open outbound"
}
  tags = {
    Name ="automate-sg"
  }
}
#AWS_EC2_instance
resource "aws_instance" "my_instance" {
 key_name = aws_key_pair.my_key.key_name
 security_groups = [aws_security_group.my_security_group.name] 
 instance_type = var.ec2_instance_type
 ami = var.ec2_ami_id #ubuntu

 root_block_device {
   volume_size = 8
   volume_type = "gp3"
 }
 tags ={
  Name = "my first terra instance"
 }
}
