variable "cidr-vpc" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc-name" {
  description = "The name for the VPC"
  type        = string
  default     = "portfolio-vpc"
}

variable "cidr-subnet1" {
  description = "The CIDR block for the subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "subnet1-name" {
  description = "The name for the first subnet"
  type        = string
  default     = "subnet1"
}

variable "cidr-subnet2" {
  description = "The CIDR block for the second subnet"
  type        = string
  default     = "10.1.2.0/24"
}

variable "subnet2-name" {
  description = "The name for the second subnet"
  type        = string
  default     = "subnet2"
}

variable "igw-name" {
  description = "The name for the Internet Gateway"
  type        = string
  default     = "portfolio-igw"
}