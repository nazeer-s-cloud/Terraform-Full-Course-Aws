resource "aws_eks_node_group" "this" {

    cluster_name = var.cluster_name
    node_group_name = var.node_group_name
    node_role_arn = aws_iam_role.node_role_arn
    subnet_ids = var.subnet_ids

    scaling_config {
      desired_size = 2
      max_size = 3
      min_size = 1
    }
  
  tags = {
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
  }
}

