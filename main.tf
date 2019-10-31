provider "aws" {
  version = "~> 2.0"
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  version = "~> 2.0"
  region = "us-east-2"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = "${var.amis["us-east-1"]}"
  instance_type = "${var.instance-t2micro}"
  # Essa chave foi gerada através do comando 
  # ssh-keygen -f terraform-aws -t rsa
  # e adicionado ao diretório ~/.ssh/ para ser referenciado quando se tentar conectar por ssh
  # ssh -i ~/.ssh/terraform-aws ubuntu@${máquina que se deseja acessar}
  key_name = "${var.key-name}"
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# Para se remover o recurso, basta retirá-lo do arquivo e dar um apply
# Também pode ser removido com o comando terraform destroy -target aws_instance.dev4 e 
# removê-los do arquivo após o comando para que não sejam aplicados novamente
#
# resource "aws_instance" "dev4" {
#   ami           = "${var.amis["us-east-1"]}"
#   instance_type = "${var.instance-t2micro}"
#   key_name      = "${var.key-name}"
#   tags = {
#     Name = "dev4"
#   }
#   vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
#   depends_on             = [aws_s3_bucket.dev4]
# }

# resource "aws_s3_bucket" "dev4" {
#   bucket = "saulocn-labs-dev4"
#   acl    = "private"

#   tags = {
#     Name = "saulocn-labs-dev4"
#   }
# }

resource "aws_s3_bucket" "homologacao" {
  bucket = "saulocn-labs-homologacao"
  acl    = "private"

  tags = {
    Name = "saulocn-labs-homologacao"
  }
}

resource "aws_instance" "dev5" {
  ami           = "${var.amis["us-east-1"]}"
  instance_type = "${var.instance-t2micro}"
  key_name      = "${var.key-name}"
  tags = {
    Name = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}


resource "aws_instance" "dev6" {
  provider = "aws.us-east-2"
  ami           = "${var.amis["us-east-2"]}"
  instance_type = "${var.instance-t2micro}"
  key_name      = "${var.key-name}"
  tags = {
    Name = "dev6"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
  depends_on = ["aws_dynamodb_table.dynamodb-homologacao"]
}


resource "aws_instance" "dev7" {
  provider = "aws.us-east-2"
  ami           = "${var.amis["us-east-2"]}"
  instance_type = "${var.instance-t2micro}"
  key_name      = "${var.key-name}"
  tags = {
    Name = "dev7"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
  depends_on = ["aws_dynamodb_table.dynamodb-homologacao"]
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider       = "aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}