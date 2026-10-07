resource "aws_security_group" "public" {
  name        = "${var.name_prefix}-public-sg"
  description = "Public instance: SSH from own IP only"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.name_prefix}-public-sg" }
}

resource "aws_security_group" "private" {
  name        = "${var.name_prefix}-private-sg"
  description = "Private instance: SSH and ping from the public instance only"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "${var.name_prefix}-private-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "public_ssh_from_my_ip" {
  security_group_id = aws_security_group.public.id
  description       = "SSH from own IP"
  cidr_ipv4         = var.my_ip_cidr
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

# Security Groups block all outbound traffic in Terraform unless a rule is added.
resource "aws_vpc_security_group_egress_rule" "public_all_out" {
  security_group_id = aws_security_group.public.id
  description       = "All outbound"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "private_ssh_from_public" {
  security_group_id            = aws_security_group.private.id
  description                  = "SSH from the public instance"
  referenced_security_group_id = aws_security_group.public.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "private_ping_from_public" {
  security_group_id            = aws_security_group.private.id
  description                  = "Ping from the public instance"
  referenced_security_group_id = aws_security_group.public.id
  ip_protocol                  = "icmp"
  from_port                    = -1
  to_port                      = -1
}

resource "aws_vpc_security_group_egress_rule" "private_all_out" {
  security_group_id = aws_security_group.private.id
  description       = "All outbound (leaves through the NAT Gateway)"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
