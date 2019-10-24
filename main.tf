provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = "ami-026c8acd92718196b"
  instance_type = "t2.micro"
  # Essa chave foi gerada através do comando 
  # ssh-keygen -f terraform-aws -t rsa
  # e adicionado ao diretório ~/.ssh/ para ser referenciado quando se tentar conectar por ssh
  # ssh -i ~/.ssh/terraform-aws ubuntu@${máquina que se deseja acessar}
  key_name = "terraform-aws"
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}


resource "aws_instance" "dev4" {
  ami           = "ami-026c8acd92718196b"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  tags = {
    Name = "dev4"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
  depends_on             = [aws_s3_bucket.dev4]
}


resource "aws_instance" "dev5" {
  ami           = "ami-026c8acd92718196b"
  instance_type = "t2.micro"
  key_name      = "terraform-aws"
  tags = {
    Name = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

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

resource "aws_s3_bucket" "dev4" {
  bucket = "saulocn-labs-dev4"
  acl    = "private"

  tags = {
    Name = "saulocn-labs-dev4"
  }
}
