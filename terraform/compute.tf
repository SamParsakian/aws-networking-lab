# Latest Amazon Linux 2023 AMI, looked up from the public AWS parameter instead of a hard-coded AMI ID.
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "public" {
  ami                         = nonsensitive(data.aws_ssm_parameter.al2023.value)
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  metadata_options {
    http_tokens = "required"
  }

  tags = { Name = "${var.name_prefix}-public-ec2" }
}

resource "aws_instance" "private" {
  ami                         = nonsensitive(data.aws_ssm_parameter.al2023.value)
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.private.id]
  associate_public_ip_address = false
  key_name                    = var.key_name

  metadata_options {
    http_tokens = "required"
  }

  # The NAT route must exist before the instance starts, so it can reach the internet right away.
  depends_on = [aws_route_table_association.private]

  tags = { Name = "${var.name_prefix}-private-ec2" }
}
