variable "region" {
  default = "us-east-1" 
}

variable "tags" {
  type = map
  default = { Name = "test-demo" }
}

variable "instance_count" {
  type                    = number
  default                 = 1 
}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = var.region
}

module "base" {
  source = "./modules/base"
  public_key_path = "~/.ssh/id_rsa.pub"
  tags = var.tags
  region = var.region
}

resource "aws_instance" "demo_servers" {
  count                   = var.instance_count 
  ami                     = "ami-02e07e1a02fcf6cf3"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [ module.base.security_group ]
  subnet_id               = module.base.subnet 
  key_name                = module.base.ssh_key_name
  tags                    = var.tags
}

output "demo_servers" {
   value                  = aws_instance.demo_servers[*].public_ip
}
