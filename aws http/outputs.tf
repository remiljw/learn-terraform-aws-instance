output "instance_id" {
  value = aws_instance.example.id
}

output "instance_tags" {
  value = aws_instance.example.tags
}

output "public_ip" {
  value = aws_instance.example.public_ip
}

output "instance_url" {
  value = "http://${aws_instance.example.public_ip}:${var.instance_port}"
}

