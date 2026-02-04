# DB Subnet Group
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "main" {
  identifier = "${var.environment}-database"
  
  # Engine Configuration
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  
  # Storage Configuration
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  storage_encrypted     = true
  
  # Database Configuration
  db_name  = "appdb"
  username = var.db_username
  password = var.db_password
  
  # Network Configuration
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  
  # Backup Configuration
  backup_retention_period = 7
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  # Other Settings
  skip_final_snapshot = true
  deletion_protection = false
  
  tags = {
    Name = "${var.environment}-database"
  }
}