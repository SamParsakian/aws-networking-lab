# AWS Networking Lab - Project Record

Detailed record of the lab, written step by step while the work is done.

## 1. Local environment preparation

Date: 2026-10-07

Before any Terraform code is written, the tools needed for the lab were checked. Nothing had to be installed. The AWS region used for the whole project is `eu-north-1` (Stockholm).

| Tool | Version found | Why it is needed |
|------|---------------|------------------|
| Git | 2.50.1 | Version control for the Terraform code and this record. |
| Terraform | 1.16.4 | Describes and creates all AWS resources as code. |
| AWS CLI | 2.37.10 | Authentication and read-only checks of what Terraform created. |
| OpenSSH client | 10.3p1 | Needed later to reach the public EC2 instance and, through it, the private one. |

### AWS access check

The AWS CLI was already configured with a login session and `eu-north-1` as the default region. `aws sts get-caller-identity` returned an IAM user, so the session is valid and Terraform can reuse it through the AWS CLI configuration. No access keys are written into the project. Only read-only commands were run, and no AWS resources exist yet.
