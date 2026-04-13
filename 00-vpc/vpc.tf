module "vpc" {

  #source                 = "git::https://github.com/mahesh-practice09/terraform-aws-vpc.git?ref=main"
  source = "../../terraform-aws-vpc"
  cidr_block             = "10.0.0.0/16"
  Project                = "Roboshop"
  Env                    = "sbx"
  public_cidr_blocks     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidr_blocks    = ["10.0.11.0/24", "10.0.12.0/24"]
  db_private_cidr_blocks = ["10.0.21.0/24", "10.0.22.0/24"]
  is_peering_required = true 

}
