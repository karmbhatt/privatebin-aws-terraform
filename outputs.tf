output "s3_bucket_name" {
  description = "PrivateBin notes storage bucket"
  value       = aws_s3_bucket.privatebin.bucket
}

output "ec2_instance_id" {
  description = "PrivateBin EC2 instance ID"
  value       = module.privatebin.instance_id
}

output "ssm_port_forward_command" {
  description = "Command to access PrivateBin through SSM"
  value       = "aws ssm start-session --target ${module.privatebin.instance_id} --document-name AWS-StartPortForwardingSession --parameters '{\"portNumber\":[\"3344\"],\"localPortNumber\":[\"3344\"]}' --region ${var.aws_region} --profile privatebin-nagarro"
}
