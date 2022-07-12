# The root module of EKS Cluster.

## This module will create:
- _EKS Cluster_
- _EKS Node Group_

## **Diagram**

![](diagram/eks.png)

## **Usage**
```terraform
module "eks_cluster" {
  source = "git::<URL_OF_MODULES_REPO>//eks_cluster?ref=main"

  vpc_id       = data.terraform_remote_state.networking.outputs.vpc_id
  eks_name     = "test1"
  eks_version  = "1.20"
  subnets      = data.terraform_remote_state.networking.outputs.private_subnets
  bastion_cidr = ["${data.aws_instance.bastion.public_ip}/32"]

  node_groups = {
    first = {
      node_group_name = "test"
      desired_size    = 3
      max_size        = 4
      min_size        = 2

      ami_type       = "AL2_x86_64"
      instance_types = ["t2.medium"]
    },
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

Commands for connecting to the EKS Cluster:
```bash
aws eks --region <eks_region> update-kubeconfig --name <eks_name>
```

## **Resources**
|Name|Type|
|----|----|
|[aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)|resource|
|[aws_eks_node_group.workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group)|resource|
|[aws_security_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)|resource|
|[aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)|resource
|[aws_security_group.worker_group_mgmt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)|resource|
|[aws_iam_role.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)|resource|
|[aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)|resource|
|[aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)|resource|
|[aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceControllerPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)|resource|
|[aws_iam_role.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)|resource|
|[aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)|resource|
|[aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)|resource|
|[aws_iam_role_policy_attachment.eks_node](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)|resource|

## **Inputs**
|Name|Description| Type| Default| Required|
|----|-----------|-----|--------|---------|
|`eks_name`|EKS Cluster name.|`string`|`EKS`|yes|
|`eks_version`|EKS Cluster version.|`string`|no|yes|
|`subnets`|Subnets list to create EKS in.|`list(string)`|no|yes|
|`node_groups`|Node groups to create.|`any`|`{}`|no|
|`vpc_id`|VPC ID to create EKS in.|`string`|no|yes|
|`bastion_cidr`|Public IP of Bastion host.|`list(string)`|`[""]`|yes|


