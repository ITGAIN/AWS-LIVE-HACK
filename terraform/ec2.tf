resource "aws_vpc" "hacking_scenario_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "hacking_scenario_subnet" {
  vpc_id     = aws_vpc.hacking_scenario_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "hacking_scenario_secgroup"{
  description = "EC2 zum Abfangen des CURL-Befehls"
  vpc_id      = aws_vpc.hacking_scenario_vpc.id

   ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH access"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress{
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    description = "general outbound"
    cidr_blocks = ["0.0.0.0/0"]
  }

  revoke_rules_on_delete  = true

  tags = local.tags
}

resource "aws_key_pair" "hacking_scenario_ec2_sshkey" {
  key_name   = "hacking_scenario_ec2_sshkey"
  public_key = "aaa" # FIXME
}

resource "aws_instance" "hacking_scenario_ec2" {
  ami           = "ami-00f22f6155d6d92c5" #Amazon Linux FreeTier
  instance_type = "t2.micro"
  subnet_id = aws_subnet.hacking_scenario_subnet.id
  vpc_security_group_ids = [aws_security_group.hacking_scenario_secgroup.id]
  key_name = aws_key_pair.hacking_scenario_ec2_sshkey.key_name

  tags = local.tags

  depends_on = [aws_subnet.hacking_scenario_subnet,aws_security_group.hacking_scenario_secgroup]
}