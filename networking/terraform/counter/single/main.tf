provider "aws" {
  region = "us-east-2"
  version = "3.8.0"
}

output "website" {
  value = aws_instance.wordpress.public_dns
}
