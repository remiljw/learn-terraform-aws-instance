variable "ec2_tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the EC2 Instance."
  default = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}

variable "s3_tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the S3 Bucket."
  default = {
    Name  = "Flugel"
    Owner = "InfraTeam"
  }
}

variable "instance_port" {
  description = "The port the EC2 Instance should listen on for HTTP requests."
  type        = number
  default     = 8080
}