resource "kubernetes_config_map_v1" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = "arn:aws:iam::083546510488:role/runner-access-eks"
        username = "runner-access-eks"
        groups   = ["system:masters"]
      },
      {
        rolearn  = "arn:aws:iam::083546510488:role/github-pipeline-eks"
        username = "github-pipeline-eks"
        groups   = ["system:masters"]
      },

      {
        rolearn  = "arn:aws:iam::083546510488:role/github-pipeline-pod"
        username = "github-pipeline-pod"
        groups   = ["system:masters"]
      }
      {
        rolearn  = aws_iam_role.eks_node_group_role.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = [
          "system:bootstrappers",
          "system:nodes"
        ]
      }
    ])
  }

  depends_on = [
    aws_eks_node_group.managed_node_group
  ]
}