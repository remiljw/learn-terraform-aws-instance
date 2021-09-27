variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "machine_image" {
  type        = string
  description = "(Optional) A state of versioning."
  default     = "ami-0133407e358cc1af0"
}

variable "instance_port" {
  description = "The port the EC2 Instance should listen on for HTTP requests."
  type        = number
  default     = 8080
}

variable "instance_type" {
  description = "The EC2 instance type to run."
  type        = string
  default     = "t2.micro"
}

variable "bucket_name" {
  type        = string
  description = "he Name tag to set for the S3 Bucket."
  default     = "flugel-bucket"
}
variable "acl" {
  type        = string
  description = " Defaults to private."
  default     = "private"
}

variable "versioning" {
  type        = bool
  description = "(Optional) A state of versioning."
  default     = true
}
variable "resource_tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the EC2 Instance."
  default = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}


