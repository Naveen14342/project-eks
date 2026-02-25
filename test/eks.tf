data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-states-prod1"
    key    = "test4/terraform.tfstate"
    region = "us-east-2"
    role_arn = "arn:aws:iam::907143134003:role/TerraformStateAccessRole"
  }

  
}

resource "aws_eks_cluster" "eks" {
    name    = "my-eks-cluster"
    role_arn = aws_iam_role.eks_cluster_role.arn
    vpc_config {
      subnet_ids = data.terraform_remote_state.network.outputs.private_subnets
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks_cluster_role_attachment
    ]
  
}

resource "aws_eks_node_group" "managed_node_group" {
    cluster_name = aws_eks_cluster.eks.name
    node_group_name = "my-managed-node-group"
    node_role_arn = aws_iam_role.eks_node_group_role.arn
    subnet_ids = data.terraform_remote_state.network.outputs.private_subnets
    scaling_config {
        desired_size = 2
        max_size = 3
        min_size = 1
    }

    capacity_type = "ON_DEMAND"
    instance_types = ["t3.medium"]
    ami_type = "AL2_x86_64"

    depends_on = [
        aws_iam_role_policy_attachment.eks_node_group_role_attachment,
        aws_iam_role_policy_attachment.eks_cni_policy_attachment,
        aws_iam_role_policy_attachment.eks_registry_policy_attachment
    ]
}