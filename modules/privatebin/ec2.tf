data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_security_group" "privatebin" {
  name        = "privatebin-ec2-sg"
  description = "PrivateBin EC2 security group - no inbound access"
  vpc_id      = "vpc-07058af0f985a0aa5"

  # No inbound rules. SSM-only access.

  egress {
    description = "Allow outbound HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "privatebin-ec2-sg"
    Component = "EC2-Networking"
  }
}

resource "aws_instance" "privatebin" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = "subnet-0b7d87c34954d435d"
  vpc_security_group_ids = [aws_security_group.privatebin.id]
  iam_instance_profile   = aws_iam_instance_profile.privatebin.name

  user_data = templatefile(var.user_data_template, {
    aws_region      = var.aws_region
    notes_bucket    = var.notes_bucket
    notes_prefix    = var.notes_prefix
    container_image = var.privatebin_image
  })

  associate_public_ip_address = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name      = "privatebin-ec2"
    Component = "Application-Compute"
  }
}
