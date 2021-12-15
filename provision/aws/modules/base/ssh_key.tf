resource "aws_key_pair" "ssh_key" {
  key_name   = "demo_ssh_key"
  public_key = file(var.public_key_path)
  tags       = var.tags
}
