data "aws_availability_zones" "available" {}

resource "aws_vpc" "expedition" {
  cidr_block = var.aws.vpc_cidr

  tags = {
    "Name" = "${var.deployment_name}-${formatdate("YYYY-MM-DD-hh-mm", timestamp())}"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.expedition.id

  # ingress {
  #   protocol  = -1
  #   self      = true
  #   from_port = 0
  #   to_port   = 0
  # }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = -1
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
}

resource "aws_subnet" "trust" {
  count             = var.aws.no_availability_zones
  cidr_block        = cidrsubnet(var.aws.vpc_cidr, 8, (count.index + 20))
  vpc_id            = aws_vpc.inbound.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "${data.aws_availability_zones.available.names[count.index]}-trust"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.expedition.id
  tags = {
    "Name" = "igw"
  }
}
