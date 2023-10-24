terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e83be366243f524a"
  instance_type = "t2.micro"
  key_name = "id_rsa"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "test-terraform"
  }
}