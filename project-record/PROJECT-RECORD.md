# AWS Networking Lab - Project Record

## Planning and environment

Before any Terraform code is written, it is checked that Git, Terraform, the AWS CLI and SSH are installed.

```
git --version
terraform version
aws --version
ssh -V
```

![Local tool versions](screenshots/local-tool-versions.png)

All four tools are installed and working. Terraform reports a newer patch release (1.16.5), which does not matter for this lab.

The AWS CLI access also works, and Stockholm (`eu-north-1`) was chosen as the region for the project. It has enough Availability Zones and supports the small EC2 instance type planned for the lab, so there was no reason to look at another region. The default VPC that AWS creates in every account is intentionally left untouched, and the lab is built inside its own VPC.
