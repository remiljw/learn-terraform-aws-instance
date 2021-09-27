output "ec2_tags" {
  value = aws_instance.app_server.tags
}

output "s3_tags" {
  value = aws_s3_bucket.bucket32.tags
}

output "public_ip" {
  value = aws_instance.app_server.public_ip
}

output "instance_id" {
  value = aws_instance.app_server.id
}

output "instance_url" {
  value = "Visit http://${aws_instance.app_server.public_ip}:${var.instance_port} in your browser."
}
