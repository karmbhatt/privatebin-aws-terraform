# PrivateBin on AWS — 10-Minute Demo Script

## 1. Introduction (1 minute)

"Today, I'll demonstrate a self-hosted PrivateBin deployment on AWS. The infrastructure is provisioned using Terraform, the application runs inside Docker on EC2, and notes are stored in Amazon S3.

The main focus is security, automation and infrastructure as code."

## 2. Architecture (2 minutes)

Explain the main components:

- EC2 runs Amazon Linux 2023 and the PrivateBin Docker container.
- S3 stores encrypted and versioned notes.
- IAM roles provide temporary AWS credentials to EC2.
- Systems Manager provides access without opening inbound ports.
- Terraform manages the infrastructure using remote state and locking.

## 3. Security (2 minutes)

Highlight these decisions:

- No inbound security-group rules.
- No SSH access.
- SSM port forwarding provides application access.
- IMDSv2 is required.
- EC2 root volume is encrypted.
- S3 public access is blocked.
- IAM permissions are restricted to the notes prefix.
- Old S3 object versions expire after 30 days.

## 4. Live Application Demo (2 minutes)

1. Show the PrivateBin application in the browser.
2. Create a sample note.
3. Retrieve the note using its generated link.
4. Show the S3 bucket and verify that note objects exist under `notes/`.

## 5. Terraform Demo (2 minutes)

Show the project structure and explain:

- Root Terraform configuration.
- Reusable `modules/privatebin` module.
- Input variables and outputs.
- Remote S3 state and state locking.
- Resource `moved` blocks used during refactoring.

Run:

```bash
terraform validate
terraform plan
```

Highlight the zero-change result.

## 6. CI/CD and Conclusion (1 minute)

Explain the GitHub Actions workflow:

- Terraform formatting.
- Terraform validation.
- TFLint.
- Checkov security scanning.

Conclude:

"The deployment demonstrates a secure and repeatable infrastructure setup using Terraform, with private application access through Systems Manager and persistent storage in S3."

