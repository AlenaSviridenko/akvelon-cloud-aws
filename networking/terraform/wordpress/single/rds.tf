resource "aws_security_group" "wordpress_db_sg" {
  description = "Open database for access"
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    security_groups = [
      aws_security_group.wordpress_sg.id]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc_wp.id
}

resource "aws_db_subnet_group" "db_sub_group" {
  name = "db_subnet_group"
  subnet_ids = [aws_subnet.priv_sub1_wp.id, aws_subnet.priv_sub2_wp.id]
}

resource "aws_db_instance" "db" {
  name                      = var.db_name
  engine                    = "MySQL"
  multi_az                  = false
  username                  = var.db_username
  password                  = var.db_password
  instance_class            = var.db_instance_type
  allocated_storage         = var.db_allocated_storage
  vpc_security_group_ids    = [aws_security_group.wordpress_db_sg.id]
  db_subnet_group_name      = aws_db_subnet_group.db_sub_group.name
  skip_final_snapshot       = true
}