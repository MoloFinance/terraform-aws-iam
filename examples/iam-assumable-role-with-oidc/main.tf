provider "aws" {
  region = "eu-west-1"
}

###############################
# IAM assumable role for admin
###############################
module "iam_assumable_role_admin" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "role-with-oidc"

  tags = {
    Role = "role-with-oidc"
  }

  provider_url  = "oidc.eks.eu-west-1.amazonaws.com/id/BA9E170D464AF7B92084EF72A69B9DC8"
  provider_urls = ["oidc.eks.eu-west-1.amazonaws.com/id/AA9E170D464AF7B92084EF72A69B9DC8"]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]

  oidc_fully_qualified_subjects = ["system:serviceaccount:default:sa1", "system:serviceaccount:default:sa2"]
}

#####################################
# IAM assumable role with self assume
#####################################
module "iam_assumable_role_self_assume" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role            = true
  allow_self_assume_role = true

  role_name = "role-with-oidc-self-assume"

  tags = {
    Role = "role-with-oidc-self-assume"
  }

  provider_url  = "oidc.eks.eu-west-1.amazonaws.com/id/BA9E170D464AF7B92084EF72A69B9DC8"
  provider_urls = ["oidc.eks.eu-west-1.amazonaws.com/id/AA9E170D464AF7B92084EF72A69B9DC8"]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]

  oidc_fully_qualified_subjects = ["system:serviceaccount:default:sa1", "system:serviceaccount:default:sa2"]
}

#####################################
# IAM assumable role with inline policy
#####################################
module "iam_assumable_role_inline_policy" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "role-with-oidc-inline-policy"

  tags = {
    Role = "role-with-oidc-inline-policy"
  }

  provider_url  = "oidc.eks.eu-west-1.amazonaws.com/id/BA9E170D464AF7B92084EF72A69B9DC8"
  provider_urls = ["oidc.eks.eu-west-1.amazonaws.com/id/AA9E170D464AF7B92084EF72A69B9DC8"]

  inline_policy_statements = [
    {
      sid = "AllowECRPushPull"
      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchCheckLayerAvailability",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetDownloadUrlForLayer",
        "ecr:ListImages",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ]
      effect    = "Allow"
      resources = ["*"]
    }
  ]

  oidc_fully_qualified_subjects = ["system:serviceaccount:default:sa1", "system:serviceaccount:default:sa2"]
}

#####################################
# IAM assumable role with session tags
#####################################
module "iam_assumable_role_session_tags" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "role-with-oidc-self-assume"

  tags = {
    Role = "role-with-oidc-self-assume"
  }

  provider_url = "oidc.eks.eu-west-1.amazonaws.com/id/BA9E170D464AF7B92084EF72A69B9DC8"

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]

  enable_session_tags = true
  oidc_session_tags   = { "Environment" : "example" }
}
