variable "amis" {
  type = "map"
  default = {
      "us-east-1" = "ami-026c8acd92718196b"
      "us-east-2" = "ami-0d8f6eb4f641ef691"
  }
}

variable "cdirs_acesso_remoto" {
  type ="list"
  default = ["200.221.157.57/32", "200.221.155.57/32"]  
}

variable "key-name" {
  type = "string"
  default = "terraform-aws"
}

variable "instance-t2micro" {
  default = "t2.micro"
}

