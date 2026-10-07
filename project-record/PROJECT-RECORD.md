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

## Terraform design

The whole lab is described in Terraform, split into a few small files so each one can be explained on its own: `networking.tf` (VPC, subnets, gateways, route tables), `security.tf` (Security Groups), `compute.tf` (the two EC2 instances), plus the usual `versions.tf`, `providers.tf`, `variables.tf` and `outputs.tf`. No modules are used, because the project is small enough to be read from top to bottom.

![Terraform file structure](screenshots/terraform-file-structure.png)

The `terraform.tfvars` file in the listing holds local values and is ignored by Git. The `.terraform` folder is ignored too, while the lock file is committed.

**Address ranges.** The VPC uses `10.0.0.0/16`, the public subnet `10.0.1.0/24` and the private subnet `10.0.2.0/24`. A private 10.x range was chosen because it does not overlap with the default VPC (`172.31.0.0/16`) that already exists in the account. The /24 subnets give 251 usable addresses each, which is far more than needed and still easy to read.

**Public versus private.** The two subnets are defined almost the same way. The public subnet is public only because its route table sends internet traffic (`0.0.0.0/0`) to the Internet Gateway. The private route table sends the same traffic to the NAT Gateway instead, and has no route to the Internet Gateway. The NAT Gateway itself sits in the public subnet, since it needs the Internet Gateway route to reach the internet, and it has an Elastic IP as its fixed public address.

**Instances.** Both instances are `t3.micro` with the latest Amazon Linux 2023 image. The image is looked up through the public AWS parameter for Amazon Linux instead of a hard-coded AMI ID, so the code does not go out of date. Only the public instance gets a public IP address.

**Security Groups.** The public instance accepts SSH only from one address, the public IP of the machine running the lab, and never from `0.0.0.0/0`. The private instance accepts SSH and ping only from the public instance's Security Group, so the only way into it is through the public instance. Both allow all outbound traffic, which for the private instance leaves through the NAT Gateway.

**Sensitive values.** The real IP address is kept in a local `terraform.tfvars` that Git ignores. The repository only contains `terraform.tfvars.example` with a placeholder. No credentials are written anywhere, because Terraform uses the existing AWS CLI login.

### What the plan shows

`terraform fmt`, `init`, `validate` and `plan` all ran cleanly. The plan creates 19 resources and changes or destroys nothing: the VPC, two subnets, the Internet Gateway, two route tables with their associations, the Elastic IP, the NAT Gateway, two Security Groups with five rules, and the two instances. In the plan the private instance has no public IP, and its only default route points to the NAT Gateway.

![Terraform plan summary](screenshots/terraform-plan-summary.png)

The end of the plan output shows the total of 19 resources to add. Nothing exists in AWS yet, because the plan was not applied.
