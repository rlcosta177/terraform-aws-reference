# the credentials are in the config and credentials files at home/.aws | C:\Users\<username>\.aws
provider "aws" {
    region = "us-east-1"
}
    
# VPC == private lan
resource "aws_vpc" "easter-main-vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "production-easter"
    }
}

# create a subnet inside the vpc created above
resource "aws_subnet" "easter-subnet" {
    vpc_id = aws_vpc.easter-main-vpc.id # associate the subnet to the vpc
    cidr_block = "10.0.1.0/24" #Subnet to be used inside the vpc(which has the /16 block)
    availability_zone = "us-east-1c" # the avail zone has to be consistent throughout the whole project ofc
    tags = {
        Name = "easter-subnet"
    }
}

#creates a gateway for the 'easter-main-vpc' vpc
resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.easter-main-vpc.id #associate the gateway to the vpc's ID

    tags = {
        Name = "easter-gateway"
    }
}

# Routing Table | only default routes are in use here(no routing between routers in the same network)
resource "aws_route_table" "easter-routing-table" {
    vpc_id = aws_vpc.easter-main-vpc.id

    #default ipv4 route, so all traffic goes through here
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }
    #default ipv6 route, so all traffic goes through here
    route {
        ipv6_cidr_block  = "::/0"
        gateway_id       = aws_internet_gateway.gateway.id
    }

    tags = {
        Name = "easter-routing-table"
    }
}

# Associates the subnet with the routing table, both created above
resource "aws_route_table_association" "easter-association" {
    subnet_id = aws_subnet.easter-subnet.id
    route_table_id = aws_route_table.easter-routing-table.id
}

# Security group associated to the above vpc
resource "aws_security_group" "allow-home-traffic" {
    name = "allow-home-traffic"
    description = "my easter security group"
    vpc_id = aws_vpc.easter-main-vpc.id #association to the vpc

    ingress {
        description = "HTTPS"
        from_port = 443 # only ingress traffic to port 443 is allowed
        to_port = 443   # I could use from_port = 443, to_port = 500 to allow traffic from ports 443 to 500
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # every ip can access the https server | i could specify the rfc1918 blocks as well or my cidr_block in the vpc
    }

    ingress {
        description = "HTTP"
        from_port = 80 # only ingress traffic to port 80 is allowed
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22 # only ingress traffic to port 22 is allowed
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" # == any protocol | So putting '0' on the ports doesn't matter, as every port is allowed anyways
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow HTTP(S) and SSH"
    }
}

# Network interface with a private IP from the subnet created(easter-subnet)
# I can have multiple NICs, but they have to be associated to an instance for it to work
resource "aws_network_interface" "web-server-nic" {
    subnet_id = aws_subnet.easter-subnet.id
    private_ips = ["10.0.1.50"]
    security_groups = [aws_security_group.allow-home-traffic.id]
}

# create an elastic IP and associate it to the network interface created above
resource "aws_eip" "easter-eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50" #has to be the same as in the aws_network_interface
  depends_on = [aws_internet_gateway.gateway] #here we reference the whole object and not just the ID

  tags = {
    Name = "easter-eip"
  }
}

# outputs the private&public ips, as well as the availability zone when terraform apply is used
# use 'terraform refresh' in a production environment | 'terraform output' in a testing environment
output "server_public_ip" {
    value = aws_instance.web-server-instance.public_ip
}
output "server_private_ip" {
    value = aws_instance.web-server-instance.private_ip
}
output "server_avail_zone" {
    value = aws_instance.web-server-instance.availability_zone
}

# create an ubuntu server for 443, 80, 22 ports
resource "aws_instance" "web-server-instance" {
    ami = var.ubuntu_ami
    instance_type = var.instance_type
    availability_zone = "us-east-1c" #set it to the same avail zone as the subnet
    key_name = "easter-terraform-aws-key" #the name has to be the same as the key-pair in aws 

    network_interface {
        device_index = 0 #meaning the 'web-server-nic' will be the 1st one(kinda like the primary NIC)
        network_interface_id = aws_network_interface.web-server-nic.id #have to specify the id of the NIC
    }

    # Make terraform run commands on the instance once it boots up
    # I am installing apache and adding some text to the index.html so that i know the commands worked.
    # EOF is used to start and end the bash code
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo my first web server > /var/www/html/index.html'
                EOF
    tags = {
        Name = "web-server"
    }
}
