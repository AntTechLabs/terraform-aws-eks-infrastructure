#======================= EKS Node Group =========================
resource "aws_eks_node_group" "workers" {
  for_each        = local.node_groups
  node_group_name = "${var.env}-${each.value.node_group_name}"

  cluster_name  = aws_eks_cluster.cluster.name
  node_role_arn = aws_iam_role.eks_node.arn
  subnet_ids    = var.subnet_ids

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  ami_type       = each.value.ami_type
  instance_types = each.value.instance_types
  disk_size      = lookup(each.value, "disk_size", null)

  tags = {
    Name = "${var.env}-${each.value.node_group_name}"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node,
    aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy
  ]

  lifecycle {
    create_before_destroy = true
  }
}

#===================== EKS Node Group Role ======================
resource "aws_iam_role" "eks_node" {
  name = "${var.env}-eks-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}



resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "eks_node" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node.name
}