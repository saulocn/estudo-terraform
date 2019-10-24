resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "Permissão de acesso via ssh"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["200.221.157.57/32"]
  }
  tags = {
    Name = "ssh"
  }
}