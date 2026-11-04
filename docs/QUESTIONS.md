# PrivateBin on AWS — Technical Questions and Answers

### 1. Why did you use Terraform?
Terraform provides Infrastructure as Code, making infrastructure repeatable, version-controlled and easier to maintain.

### 2. Why use EC2?
EC2 provides a simple way to host the Dockerized PrivateBin application with control over the operating system and runtime.

### 3. Why use Amazon S3?
S3 provides durable object storage for PrivateBin notes, with encryption and versioning.

### 4. Why enable S3 versioning?
Versioning preserves previous object versions, helping recover from accidental overwrites or deletions.

### 5. What is an S3 lifecycle policy?
It automatically manages object versions based on defined rules. This project expires noncurrent note versions after 30 days.

### 6. Why use an IAM role instead of access keys?
An EC2 IAM role provides temporary credentials automatically. Static access keys do not need to be stored on the instance.

### 7. What is least privilege?
It means granting only the permissions required. The application role is restricted to listing the bucket under the notes prefix and accessing objects within that prefix.

### 8. Why use Systems Manager instead of SSH?
SSM provides secure instance administration and port forwarding without requiring SSH keys or inbound port 22.

### 9. How can users access PrivateBin without opening inbound ports?
AWS SSM port forwarding creates a tunnel from local port 3344 to EC2 port 3344.

### 10. What is IMDSv2?
Instance Metadata Service Version 2 uses a session-oriented token mechanism to improve protection against certain metadata access attacks.

### 11. What is Terraform remote state?
It stores Terraform's state file in a shared remote backend instead of only on a developer's machine.

### 12. Why use state locking?
Locking prevents multiple Terraform operations from modifying the same state simultaneously.

### 13. What does a Terraform module provide?
A module groups related resources into reusable components. This project groups EC2, IAM and networking resources.

### 14. What are Terraform moved blocks?
They tell Terraform that a resource has a new address, allowing refactoring without destroying and recreating the actual resource.

### 15. What is Checkov?
Checkov scans infrastructure-as-code configurations for security and compliance issues.

### 16. What is TFLint?
TFLint identifies Terraform configuration issues, including provider-specific errors and potential mistakes.

### 17. How does the application authenticate with S3?
The EC2 instance receives temporary credentials through its IAM instance profile, which the application uses through the AWS credential chain.

### 18. How did you verify the deployment?
I checked EC2 and SSM status, Docker container health, the HTTP 200 response, note retrieval and the corresponding S3 objects.

### 19. How would you improve this architecture for production?
I would consider private subnets, VPC endpoints, an Application Load Balancer with HTTPS, monitoring, backups and a managed container platform.

### 20. How do you avoid unnecessary AWS charges?
Destroy the application infrastructure after the demonstration and retain the separately managed Terraform state bucket.

