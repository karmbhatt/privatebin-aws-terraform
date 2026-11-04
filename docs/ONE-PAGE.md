# PrivateBin on AWS — Architecture Overview

## Project Objective

Deploy a secure, self-hosted PrivateBin application on AWS using Terraform, Docker, Amazon EC2, Amazon S3 and AWS Systems Manager.

## Architecture

```text
                 User Browser
                      |
                      v
              localhost:3344
                      |
                      v
             AWS SSM Port Forwarding
                      |
                      v
             EC2 - Amazon Linux 2023
                      |
                      v
              Docker Container
              PrivateBin 2.0.6
                      |
                      v
             Amazon S3 Bucket
             Encrypted + Versioned
```

## Infrastructure Components

| Component | Implementation |
|---|---|
| Compute | EC2 t3.micro |
| Operating System | Amazon Linux 2023 |
| Application | PrivateBin S3 Docker image 2.0.6 |
| Storage | Amazon S3 |
| Encryption | S3 server-side AES256 |
| Versioning | S3 versioning enabled |
| Lifecycle | Noncurrent versions expire after 30 days |
| Access | AWS Systems Manager |
| Identity | EC2 IAM role |
| Infrastructure as Code | Terraform |
| State Management | Remote S3 backend with lockfile |

## Security Design

- No inbound security-group rules.
- No SSH access.
- SSM provides administrative access and application port forwarding.
- EC2 uses an IAM instance profile rather than static credentials.
- S3 access is restricted to the `notes/` prefix.
- S3 public access is completely blocked.
- EC2 requires IMDSv2.
- EC2 root volume uses encrypted gp3 storage.

## Deployment Validation

The deployment was verified through:

1. Successful EC2 launch.
2. SSM agent registered as Online.
3. Docker container running successfully.
4. PrivateBin returned HTTP 200 OK.
5. Test notes were created and retrieved.
6. S3 objects were verified under the `notes/` prefix.
7. Terraform module refactor completed with zero resources added, changed or destroyed.

## Cost Management

The deployment uses a small EC2 instance and S3 storage. Application resources should be destroyed after the demonstration to avoid unnecessary charges. The separately managed Terraform state bucket is retained.
