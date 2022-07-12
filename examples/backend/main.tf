#===================== Backend root module ======================

module "backend" {
  source = "git::https://github.com/tynchtyk642/terraform-aws-modules.git//backend_bucket?ref=main"
  env    = "me"
}



