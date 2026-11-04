resource "aws_iam_role" "privatebin_ec2" {
  name = "privatebin-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name      = "privatebin-ec2-role"
    Component = "EC2-IAM"
  }
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.privatebin_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "privatebin_s3" {
  name = "privatebin-s3-access"
  role = aws_iam_role.privatebin_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = var.notes_bucket_arn
        Condition = {
          StringLike = {
            "s3:prefix" = ["${var.notes_prefix}", "${var.notes_prefix}*"]
          }
        }
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "${var.notes_bucket_arn}/${var.notes_prefix}*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "privatebin" {
  provider = aws.untagged

  name = "privatebin-ec2-instance-profile"
  role = aws_iam_role.privatebin_ec2.name
}
