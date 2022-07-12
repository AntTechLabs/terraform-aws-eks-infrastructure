# The root module of S3 Buckets for .tfstate files.

## This module will create:
- _s3 Buckets for to store .tfstate files_

## **Usage**
```terraform
module "backend" {
  source = "git::<URL_OF_REPO>//backend_bucket?ref=main"
  env    = "UAT"
}
```
```bash
export AWS_ACCESS_KEY_ID=<write your access key id>
export AWS_SECRET_ACCESS_KEY=<write you secret access key>
export AWS_DEFAULT_REGION=<write default region to create resource in>
```

Then perform the following commands on the root folder:
- `terraform init` terraform initialization
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply infrastructure build
- `terraform destroy` to destroy the infrastructure

# **Resources**
|Name | Type|
|-----|-----|
|[aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)|resource|
|[aws_s3_bucket_public_access_block.block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block)|resource|
|[aws_s3_bucket_acl.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)|resource|
|[aws_s3_bucket_server_side_encryption_configuration.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration)|resource|
|[aws_s3_bucket_versioning.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)|resource|
|[aws_kms_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)|resource|
|[aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias)|resource|
|[aws_dynamodb_table.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)|resource|

# **Inputs**
|Name|Description|Type|Default|Required|
|----|-----------|----|-------|--------|
|`tags`|A mapping of tags to assign.|`map(string)`|`{}`|no|
|`env`|Environment name to create resource in.|`string`|no|yes|
|`bucket_versioning`|The bucket and all objects should be destroyed when using true.|`bool`|`true`|yes|
|`kms_enable_key_rotation`|Enable key rotation for the KMS key.|`bool`|`false`|no|
|`read_capacity`|The number of read units for this table.|`number`|`20`|no|
|`write_capacity`|The number of write units for this table.|`number`|`20`|no|
|`hash_key`|The name of the hash key in the index; must be defined as an attribute in the resource.|`string`|`LockID`|no|

# **Outputs**
|Name|Description|
|----|-----------|
|`bucket_name`|Bucket name.|
|`dynamodb_name`|The name of the table.|