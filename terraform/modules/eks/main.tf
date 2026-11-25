resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "eks_nodes" {
  name = "${var.project_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_eks_cluster" "main" {
  name                          = "${var.project_name}-eks"
  role_arn                      = aws_iam_role.eks_cluster.arn
  bootstrap_self_managed_addons = false
  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}

resource "aws_eks_node_group" "node_1" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-1"
  node_role_arn   = aws_iam_role.eks_nodes.arn

  subnet_ids = [var.private_subnet_ids[0]]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
}

resource "aws_eks_node_group" "node_2" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-2"
  node_role_arn   = aws_iam_role.eks_nodes.arn

  subnet_ids = [var.private_subnet_ids[1]]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
}
