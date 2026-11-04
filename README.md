# PrivateBin on AWS using Terraform

## Overview

This project deploys PrivateBin on AWS using Terraform and Docker. It uses Amazon S3 for encrypted, versioned note storage and AWS Systems Manager (SSM) for secure access without SSH or inbound security-group rules.

## Architecture

- **Amazon EC2:** Runs PrivateBin using `privatebin/s3:2.0.6` on a `t3.micro` instance.
- **Amazon S3:** Stores PrivateBin notes with server-side encryption and versioning.
- **IAM:** EC2 instance role provides least-privilege access to the S3 `notes/` prefix.
- **AWS Systems Manager:** Provides secure access and port forwarding without SSH.
- **Terraform:** Provisions infrastructure and manages remote state with locking.

## Architecture Flow

```text
Browser (localhost:3344)
          |
          v
AWS SSM Port Forwarding
          |
          v
EC2 Instance (Amazon Linux 2023)
          |
          v
Docker Container (PrivateBin)
          |
          v
Amazon S3 (Encrypted + Versioned)
```

## Prerequisites

- AWS account with required permissions
- AWS CLI configured
- Terraform >= 1.10
- AWS Session Manager Plugin
- Git

## Deployment

Initialize Terraform:

```bash
terraform init
```

Format and validate:

```bash
terraform fmt -recursive
terraform validate
```

Review the infrastructure plan:

```bash
terraform plan
```

Apply after reviewing the plan:

```bash
terraform apply
```

## Access PrivateBin

Retrieve the SSM port-forward command:

```bash
terraform output -raw ssm_port_forward_command
```

Run the command and keep the session open.

Open the application:

http://localhost:3344

## Terraform Outputs

```bash
terraform output
```

The outputs provide:

- S3 bucket name
- EC2 instance ID
- SSM port-forward command

## Security Features

- No inbound security-group rules.
- No SSH access required.
- IMDSv2 is required.
- EC2 root volume is encrypted.
- S3 server-side encryption enabled.
- S3 versioning enabled.
- S3 public access blocked.
- IAM role used instead of hardcoded AWS credentials.
- S3 permissions restricted to the application notes prefix.
- Noncurrent S3 object versions expire after 30 days.

## Remote Terraform State

Terraform state is stored in a dedicated S3 bucket with encryption, versioning and state locking enabled.

The state bucket is managed separately from the application infrastructure.

## Cleanup

After completing the assignment demonstration, remove application resources to avoid unnecessary AWS charges:

```bash
terraform destroy
```

The separately bootstrapped Terraform state bucket is not part of the application resources and is retained.

## Technologies Used

- Terraform
- AWS EC2
- Amazon S3
- AWS IAM
- AWS Systems Manager
- Docker
- PrivateBin




