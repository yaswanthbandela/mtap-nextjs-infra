resource "aws_security_group" "mtap_nextjs_server_sg" {
  name        = "mtap-nextjs-server-sg"
  description = "Allow ssh, http and https inbound traffic"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH from any IP, you may want to restrict this
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP
  }
    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTPS
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}
resource "aws_iam_instance_profile" "codedeploy_ec2_instance_profile" {
  name = "codedeploy_ec2_instance_profile"
  role = aws_iam_role.codedeploy_ec2_role.name
}

resource "aws_instance" "mtap_nextjs_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data = templatefile("${path.module}/userdata.sh", {
    domain_name = var.domain_name
    })
  iam_instance_profile = aws_iam_instance_profile.codedeploy_ec2_instance_profile.name
  security_groups = [aws_security_group.mtap_nextjs_server_sg.name]

  tags = {
    Name = "mtap-nextjs-server"
  }
}
