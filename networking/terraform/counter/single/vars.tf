# EC2 block

variable "ec2_keypair_name" {
  type    = string
  default = "simple-server-key"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}
variable "ec2_ami" {
  type    = string
  default = "ami-0e82959d4ed12de3f"
}

# Database block

variable "db_instance_type" {
  type    = string
  default = "db.t2.micro"
}

variable "db_username" {
  type    = string
  default = "user"
}

variable "db_password" {
  type    = string
  default = "abc123456"
}

variable "db_name" {
  type    = string
  default = "wordpress_db"
}

variable "db_allocated_storage" {
  type = number
  default = 5
}

# VPC block

variable "vpc_cidr" {
    type    = string
    default = "10.192.0.0/16"
}

variable "public_subnet1_cidr" {
    type    = string
    default = "10.192.10.0/24"
}

variable "public_subnet2_cidr" {
    type    = string
    default = "10.192.11.0/24"
}

variable "private_subnet1_cidr" {
    type    = string
    default = "10.192.20.0/24"
}

variable "private_subnet2_cidr" {
    type    = string
    default = "10.192.21.0/24"
}

variable "a_zones" {
    type = list
    default = ["us-east-2a", "us-east-2b"]
}
