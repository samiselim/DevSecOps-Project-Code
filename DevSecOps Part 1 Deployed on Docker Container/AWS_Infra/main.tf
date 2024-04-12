resource "aws_vpc" "vpc" {
    cidr_block       = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags = {
    Name = "${var.sub_prefix}-vpc"
    }
}
resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.subnet1-cidr
  availability_zone = var.zone
  map_public_ip_on_launch = true
  tags = {
    Name: "${var.sub_prefix}-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name: "${var.sub_prefix}-igw"
    }
}
resource "aws_route_table" "rtb" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block ="0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name: "${var.sub_prefix}-rtb"
    }
}
resource "aws_route_table_association" "rtb_association1" {
    subnet_id = aws_subnet.subnet.id
    route_table_id = aws_route_table.rtb.id
}
resource "aws_security_group" "sg" {
    name = "${var.sub_prefix}-sg"
    vpc_id = aws_vpc.vpc.id
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0 
        protocol = "-1"  
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name: "${var.sub_prefix}-sg"
    }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t3.large"
    key_name = "projKey"
    subnet_id = aws_subnet.subnet.id
    security_groups = [aws_security_group.sg.id]
    user_data = file("script.sh")
    root_block_device {
        volume_size = 50
        volume_type = "gp3"
    }
    tags = {
        Name = "ubuntu"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.ubuntu.id
   tags = {
    Name = "eip-jenkins"
  }
}

resource "aws_instance" "monitor_server" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.medium"
    key_name = "projKey"
    subnet_id = aws_subnet.subnet.id
    security_groups = [aws_security_group.sg.id]
    user_data = file("monitor-script.sh")
    root_block_device {
        volume_size = 50
        volume_type = "gp3"
    }
    tags = {
        Name = "monitor-server"
  }
}
resource "aws_eip" "eip2" {
  instance = aws_instance.monitor_server.id
   tags = {
    Name = "eip-monitor"
  }
}