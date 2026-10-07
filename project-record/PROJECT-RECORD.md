# AWS Networking Lab - Project Record

## 1. Local environment check

Before writing any Terraform code, I checked that Git, Terraform, the AWS CLI and SSH are installed.

```
git --version
terraform version
aws --version
ssh -V
```

![Local tool versions](screenshots/local-tool-versions.png)

All four tools are installed and working. Terraform reports a newer patch release (1.16.5), which does not matter for this lab.

## 2. AWS readiness check

Only read-only AWS CLI commands were used here. Nothing was created or changed.

- The AWS CLI uses the `default` profile with a browser-based login session, signed in as an IAM user (not the root user). The default region in the CLI configuration is `eu-north-1`.
- `eu-north-1` (Stockholm) was chosen for the lab. It has three Availability Zones (`a`, `b`, `c`), all available without opt-in, and the small instance types planned for the lab (`t3.nano`, `t3.micro`, `t3.small`) are offered in all three.
- The account is empty in this region apart from the default VPC (`172.31.0.0/16`). There are no EC2 instances, NAT Gateways or Elastic IPs yet.
- Service quotas are enough for this lab: 5 VPCs per region, 5 NAT Gateways per Availability Zone, 5 Elastic IPs and 16 running On-Demand standard instances.

The default VPC is left untouched. The lab creates its own VPC, so the two do not interfere. A CIDR range that does not overlap with `172.31.0.0/16` will be chosen for it.
