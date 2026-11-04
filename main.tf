# PrivateBin application storage bucket
resource "aws_s3_bucket" "privatebin" {
  bucket = "privatebin-notes-904869824787-1793773713"

  tags = {
    Name      = "privatebin-notes"
    Component = "Application-Storage"
  }
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "privatebin" {
  bucket = aws_s3_bucket.privatebin.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "privatebin" {
  bucket = aws_s3_bucket.privatebin.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "privatebin" {
  bucket = aws_s3_bucket.privatebin.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Expire old versions of notes after 30 days
resource "aws_s3_bucket_lifecycle_configuration" "privatebin" {
  bucket = aws_s3_bucket.privatebin.id

  depends_on = [
    aws_s3_bucket_versioning.privatebin
  ]

  rule {
    id     = "expire-old-note-versions"
    status = "Enabled"

    filter {
      prefix = var.notes_prefix
    }

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_version_expiration_days
    }
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}
module "privatebin" {
  source = "./modules/privatebin"

  providers = {
    aws          = aws
    aws.untagged = aws.untagged
  }

  aws_region         = var.aws_region
  instance_type      = var.instance_type
  privatebin_image   = var.privatebin_image
  notes_prefix       = var.notes_prefix
  notes_bucket       = aws_s3_bucket.privatebin.bucket
  notes_bucket_arn   = aws_s3_bucket.privatebin.arn
  user_data_template = "${path.root}/user_data.sh.tftpl"
}
