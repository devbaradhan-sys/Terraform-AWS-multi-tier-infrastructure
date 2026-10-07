resource "aws_instance" "my_server" {
    ami = "ami-08e3b3155fc937a94"
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