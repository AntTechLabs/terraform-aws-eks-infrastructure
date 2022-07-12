# The root module of Networking.

## This module will create:
- _VPC_
- _Public Subnets_
- _Private Subnets_

## **Diagram**

![](diagram/Network.png)

## **Usage**
```terraform
module "networking" {
  source = "git::<URL_OF_REPO>//networking?ref=main"  # <== Path to  the networking module.

  vpc_cidr         = var.vpc_cidr
  public_sn_count  = 3
  private_sn_count = 3
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
| Name | Type |
|------|------|
|[aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)| resource|
|[aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)| resource|
|[random_integer.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer)| resource|
|[aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)|resource|
|[aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)|resource|
|[aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)|resource|
|[aws_route.public_igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)|resource|
|[aws_route_table_association.public_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)|resource|
|[aws_route_table.private_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_tablea)|resource|
|[aws_route.private_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)|resource|
|[aws_route_table_association.private_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association)|resource|
|[aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway)|resource|
|[aws_eip.nat_eip](nat_eip)|resource|

## **Inputs**
| Name| Description| Type| Default| Required |
|-----|------------|-----|--------|----------|
|``vpc_cidr`` | The IPv4 CIDR block for the VPC. | `string` | `no` | yes |
| ``public_sn_count`` | Amount of Public Subnets to create | `number` | `no` | yes|
|``private_sn_count`` | Amount of Private Subnets to create | `number` | `no` | yes|
| ``max_subnets`` | Max amount of subnets | `number` | `20` | no |
| `env`| Environment name to create resource in.| `string` | no | yes|

## **Outputs**
|Name|Description|
|----|-----------|
|`vpc_id`|The ID of the VPC.|
|`public_subnets`|The IDs of Public Subnets.|
|`private_subnets`|The IDs of the Private Subnets.|