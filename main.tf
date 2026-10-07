resource "aws_vpc" "vpcconfig" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terraform-v2-vpc"
  }
}

resource "aws_internet_gateway" "internetconfig" {
  vpc_id = aws_vpc.vpcconfig.id

  tags = {
    Name = "terraform-v2-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpcconfig.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-v2-public-subnet"
  }

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpcconfig.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internetconfig.id
  }

  tags = {
    Name = "terraform-v2-public-route"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id

}
resource "aws_instance" "my_server" {
  ami           = "ami-08e3b3155fc937a94"
  instance_type = "t3.micro"

  user_data = <<-EOF
                #!/bin/bash
                yum install -y httpd 
                systemctl start httpd
                systemctl enable httpd 
                echo '<h1>Hello from Terraform, this is for learning using terraform.</h1>' > /var/www/html/index.html
                EOF
  tags = {
    Name = "Terraform_inst_sample"
  }
}

resource "aws_security_group" "web" {
  name   = "terraform-v2-web-sg"
  vpc_id = aws_vpc.vpcconfig.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-v2-web-sg"
  }
}
