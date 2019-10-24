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

resource "aws_s3_bucket" "dev4" {
  bucket = "saulocn-labs-dev4"
  acl    = "private"

  tags = {
    Name = "saulocn-labs-dev4"
  }
}
