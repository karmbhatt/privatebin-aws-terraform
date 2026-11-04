output "instance_id" {
  description = "PrivateBin EC2 instance ID"
  value       = aws_instance.privatebin.id
}

output "iam_role_name" {
  description = "EC2 IAM role name"
  value       = aws_iam_role.privatebin_ec2.name
}

output "security_group_id" {
  description = "PrivateBin security group ID"
  value       = aws_security_group.privatebin.id
}
