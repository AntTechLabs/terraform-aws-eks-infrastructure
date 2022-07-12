# The root module of Bastion.

## This module will create:
- _SSH Bastion host_

## **Diagram**
This module will create an SSH Bastion to securly connect in SSH to your private instances.
![](diagram/bastion.png)

All SSH commands are logged on an S3 Bucket for security compliance, in the `logs/` path.

SSH users are managed by their public key, simply drop the SSH key of the user in the /public-keys path of the bucket. Keys should be named like `username.pub`, this will create the user username on the bastion server. Username must contain alphanumeric characters only.

Then after you'll be able to connect to the server with:
```bash
ssh -i [path_to_the_private_key] username@bastion-dns-name[or PUBLIC_IP]
```
From this bastion server, you will be able to connect to all instances on the private subnet.


## **Usage**
```terraform
module "bastion" {
  source = "git::<URL_OF_MODULES_REPO>//bastion?ref=main" # <== Path to bastion module.

  bastion_name          = var.bastion_name
  bucket_name           = "s3-for-public-key"
  region                = "us-east-1"
  vpc_id                = <VPC_ID>
  is_lb_private         = true
  bastion_host_key_pair = <KEY_PAIR_NAME>




  elb_subnets         = <SUBNET_IDS>
  autoscaling_subnets = <SUBNET_IDS>

  tags = {
    name        = "my_bastion_name"
    description = "my_bastion_description"
  }
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

## **Resources**
|Name|Type|
|----|----|
|[aws_iam_role.bastion_host_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)|resource|
|[aws_iam_policy.bastion_host_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)|resource|
|[aws_iam_role_policy_attachment.bastion_host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment)|resource|
|[aws_iam_instance_profile.bastion_host_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)|resource|
|[aws_launch_template.bastion_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)|resource|
|[aws_autoscaling_group.bastion_auto_scaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)|resource|
|[aws_security_group.private_instances_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)|resource|
|[aws_security_group_rule.ingress_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)|resource|
|[aws_security_group_rule.egress_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)|resource|
|[aws_security_group.bastion_host_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)|resource|
|[aws_security_group_rule.ingress_bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)|resource|
|[aws_lb.bastion_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)|resource|
|[aws_lb_target_group.bastion_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group)|resource|
|[aws_lb_listener.bastion_lb_listener_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener)|resource|
|[aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)|resource|
|[aws_s3_bucket_acl.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl)|resource|
|[aws_s3_bucket_server_side_encryption_configuration.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration)|resource|
|[aws_s3_bucket_versioning.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning)|resource|
|[aws_s3_bucket_lifecycle_configuration.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration)|resource|
|[aws_s3_object.bucket_public_keys_readme](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)|resource|
|[aws_kms_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)|resource|
|[aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias)|resource|
|[aws_kms_alias.kms-ebs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias)|data source|
|[aws_ami.amazon-linux-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)|data source|
|[aws_subnet.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet)|data source|

## **Inputs**
|Name|Description|Type|Default|Required|
|----|-----------|----|-------|--------|
|`tags`|A mapping of tags to assign.|`map(string)`|`{}`|no|
|`bastion_ami`|The AMI that the Bastion Host will use.|`string`|`""`|yes|
|`associate_public_ip_address`|Whether to associate a public IP address with an instance in a VPC.|`bool`|`true`|no|
|`bastion_additional_security_groups`|List of additional security groups to attach to the launch template|`list(string`|`[]`|no|
|`region`|Region where the Bastion will located|`string`|no|yes|
|`extra_user_data_content`|Additional scripting to pass to the bastion host. For example, this can include installing postgresql for the 'psql' command.| `string`|`""`|no|
|`enable_logs_s3_sync`|Enable cron job to copy logs to S3.|`bool`|`true`|no|
|`disk_encrypt`|Instance EBS encrypt.|`bool`|`true`|no|
|`disk_size`|Root EBS size.|`number`|`8`|no|
|`bastion_name`|Bastion Launch template Name, will aslo be used for the ASG.|`string`|`bastion`|no|
|`autoscaling_subnets`|List of subnet were the Auto Scaling Group will deploy the instnaces.|`list(string)`|no|yes|
|`bastion_security_group_id`|Custom security to use.|`string`|`""`|no|
|`allow_ssh_commands`|Allows the SSH uset to execute one-off commands. Pass true to enable. Warning: These commands are not logged and increase the vulnerability of the system. Use at your own discretion.|`bool`|`false`|no|
|`cidrs`|List of CIDRs than can access to the bastion.|`list(string)`|`["0.0.0.0/0",]`|no|
|`vpc_id`|VPC ID were we'll deploy the bastion.|`string`|no|yes|
|`public_ssh_port`|Set the SSH port to use from desktop to the bastion.|`number`|22|no|
|`ipv6_cidrs`|List of IPv6 CIDRs than can access to the bastion.|`list(string)`|`["::/0",]`|no|
|`private_ssh_port`|Set the SSH port to use between the bastion and private instance.|`number`|22|no|
|`bastion_host_key_pair`|Select the key pair to use to launch the bastion host.|`string`|no|no|
|`bucket_name`|Bucket name were the bastion will store the logs.|`string`|no|no|
|`bucket_force_destroy`|The bucket and all objects should be destroyed when using true.|`bool`|`true`|no|
|`bucket_versioning`|The bucket and all objects should be destroyed when using true.|`bool`|`true`|yes|
|`log_expiry_days`|Number of days before logs expiration.|`number`|`90`|yes|
|`log_auto_clean`|Enable or note the lifecycle.|`bool`|`false`|no|
|`kms_enable_key_rotation`|Enable key rotation fo the KMS key|`bool`|`false`|no|
|`is_lb_private`|If TRUE the load balacner scheme will be \"internal\" else \"internet-facing\""|`bool`|no|yes|
|`elb_subnets`|List of subnet were the ELB will be deployed.|`list(string)`|no|no|
|`bastion_iam_role_name`|IAM role name to create.|`string`|`null`|no|
|`bastion_iam_permissions_boundary`|IAM Role Permissions Boundary to constrain the bastion host role.|`string`|`""`|no|
|`bastion_iam_policy_name`|IAM policy name to create for granting the instance role access to the bucket.|`string`|`BastionHost`|no|

## **Outputs**
|Name|Description|
|----|-----------|
|`bastion_host_security_group`|Bastion host Security Group ID.|
|`bucket_kms_key_alias`|Alias name of Bucket KMS key.|
|`bucket_name`|Bucket name.|
|`elb_ip`|DNS name of Load Balancer.|

