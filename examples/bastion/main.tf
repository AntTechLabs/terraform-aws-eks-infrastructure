#======================= Bastion root module ========================
module "bastion" {
  source = "git::https://github.com/tynchtyk642/terraform-aws-modules.git//bastion?ref=main"

  bastion_name = var.bastion_name

  bucket_name           = "s3-for-public-key"
  region                = "us-east-1"
  vpc_id                = data.terraform_remote_state.networking.outputs.vpc_id
  is_lb_private         = true
  bastion_host_key_pair = aws_key_pair.test.key_name
  env                   = var.env




  elb_subnets         = data.terraform_remote_state.networking.outputs.public_subnets
  autoscaling_subnets = data.terraform_remote_state.networking.outputs.public_subnets

  tags = {
    name        = "my_bastion_name"
    description = "my_bastion_description"
  }
}

resource "aws_key_pair" "test" {
  key_name   = "${var.env}-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIrWpVGTN+jtNaYKsE54trP8LzCy+WUg89+P+1bpZdauGOwbxFShVk9Wk/8pFYkAYzxa73OEr1u/GYVBXPR8RXvf9MftWlBjIWxgC1AdvdlGkSxBzi2TGIV7hq51hJQMsKy12uHGqK/pCqP8VQBA07HTBi2XUuzwdQNCCXqWS3bbbatMnxqA7qO+DzBmJVf/W6OntIermy74kTty763LYS/buIjIY+WWxsC+FAKezLUI0Pk3KXA+1NjdWTNpJYa93zIa/6jecu83ytF63HbxK4KXAZT87biZNgUJw1oeMHDXNWhZWbErZAIaY+CI2u7ajFGRvkHYmDdRfLnBTSFErgT0JKxHRo/W0XH0fG3zDUvXJUgUCi2elZ8qw76YR7Y98iNke/Mn/vV1wNcik/cbsKVNZvf0v0qw8ouMPM3DOlYKdS8I0xOQozTm6NnRwOzZ1QFWKlP4WdRXzvGEjwJAxmgvC9i4ve0xAEq3fLRDDRWN8W5/6GkPQkIVKFctwT8ME= Ant@DESKTOP-AAVPF15"
}
