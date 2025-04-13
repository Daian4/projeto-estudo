variable "prefix" {}
variable "ami_id" {
  description = "ID da AMI for instance"
  type        = string
}

variable "instance_type" {
  description = " instance type"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {
    Name        = "wordpress"
    owner       = "Daiana"
    Environment = "Development"
    Project     = "WordPress"
  }
}

variable "allowed_cidr_blocks" {
  description = "allowed_cidr_blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"] 
}

variable "rtb_cidr_block" {
  description = " vpc cidr block"
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpc_tags" {
  description = "vpc for tags"
  type        = map(string)
  default     = {
    Name        = "new-vpc"
    Environment = "Development"
  }
}

variable "sg_tags" {
  description = "Tags for Security Group"
  type        = map(string)
  default     = {
    Name        = "wordpress-sg"
    Environment = "Development"
  }
}

variable "igw_tags" {
  description = "Tags for internet gateway"
  type        = map(string)
  default     = {
    Name        = "wordpress-igw"
    Environment = "Development"
  }
}

variable "rtb_tags" {
  description = "Tags for route table"
  type        = map(string)
  default     = {
    Name        = "wordpress-rtb"
    Environment = "Development"
  }
}