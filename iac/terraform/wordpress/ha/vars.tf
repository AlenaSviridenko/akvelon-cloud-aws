variable "ec2_keypair_name" {
  type    = string
  default = "simple-server-key"
}

variable "ec2_ami" {
  type    = string
  default = "ami-0e82959d4ed12de3f" # ubuntu image
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

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

variable "vpc_id" {
  type    = string
  default = "vpc-e19e308a"
}

variable "subnet_ids" {
  type    = list
  default = [ "subnet-472dfb2c", "subnet-7a404f00" ]
}

variable "region" {
  type    = string
  default = "us-east-2"
}
