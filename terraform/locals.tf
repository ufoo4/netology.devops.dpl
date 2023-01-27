locals {
  network_cidr          = lookup(var.network_cidr, terraform.workspace, null)
  private_subnet_cidrs  = lookup(var.private_subnet_cidrs, terraform.workspace, null)
  public_subnet_cidrs   = lookup(var.public_subnet_cidrs, terraform.workspace, null)
}
