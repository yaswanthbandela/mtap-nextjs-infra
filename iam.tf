# CodePipeline IAM Role
resource "aws_iam_role" "codepipeline_role" {
  name = "CodePipelineServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}

# Adding required access to S3 and CloudWatch for pipeline
resource "aws_iam_policy" "codepipeline_additional_policy" {
  name = "CodePipelineAdditionalPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.codepipeline_bucket.arn}",
          "${aws_s3_bucket.codepipeline_bucket.arn}/*"
        ]
        Effect = "Allow"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
        Effect = "Allow"
      },
      {
        Action = [
          "codestar-connections:UseConnection"
        ]
        Resource = "arn:aws:codestar-connections:${var.region}:${var.account_id}:connection/*"
        Effect = "Allow"
      },
      {
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds"
        ]
        Resource = [
          "arn:aws:codebuild:${var.region}:${var.account_id}:project/*"
        ]
        Effect = "Allow"
      },
      {
            "Effect": "Allow",
            "Action": [
                "codedeploy:CreateDeployment",
                "codedeploy:GetDeployment",
                "codedeploy:StopDeployment",
                "codedeploy:ListDeployments",
                "codedeploy:GetDeploymentConfig",
                "codedeploy:RegisterApplicationRevision",
                "codedeploy:CreateDeploymentConfig",
                "codedeploy:ListDeploymentConfigs",
                "codedeploy:GetApplicationRevision" 
            ],
            Resource= [ 
              "arn:aws:codedeploy:${var.region}:${var.account_id}:deploymentgroup:${aws_codedeploy_app.mtap_nextjs_deploy.name}/*",
              "arn:aws:codedeploy:${var.region}:${var.account_id}:application:${aws_codedeploy_app.mtap_nextjs_deploy.name}",
              "arn:aws:codedeploy:${var.region}:${var.account_id}:deploymentconfig:CodeDeployDefault.AllAtOnce"
            ]
        },
        {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:StopInstances",
          "ec2:StartInstances",
          "ec2:TerminateInstances",
          "ec2:DescribeRegions",
          "tag:GetResources"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_additional_policy_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_additional_policy.arn
}

# CodeDeploy IAM Role
resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "codedeploy.amazonaws.com"
      }
    }
    
      ]
  })
}
resource "aws_iam_policy" "codedeploy_additional_policy" {
  name = "CodeDeployAdditionalPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [   
     {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:StopInstances",
          "ec2:StartInstances",
          "ec2:TerminateInstances",
          "ec2:DescribeRegions",
          "tag:GetResources"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_additional_policy_attach" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = aws_iam_policy.codedeploy_additional_policy.arn
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

# CodeBuild IAM Role
resource "aws_iam_role" "codebuild_role" {
  name = "codebuild_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# Additional permissions for S3, CloudWatch, and ECR in CodeBuild
resource "aws_iam_policy" "codebuild_additional_policy" {
  name = "CodeBuildAdditionalPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${aws_s3_bucket.codepipeline_bucket.arn}",
          "${aws_s3_bucket.codepipeline_bucket.arn}/*"
        ]
        Effect = "Allow"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
        Effect = "Allow"
      },
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Resource = "*"
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_additional_policy_attach" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_additional_policy.arn
}

# EC2 IAM Role for CodeDeploy
resource "aws_iam_role" "codedeploy_ec2_role" {
  name = "codedeploy_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_ec2_policy" {
  role       = aws_iam_role.codedeploy_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

# Additional permissions for S3 in CodeDeploy EC2 Role
resource "aws_iam_policy" "codedeploy_ec2_additional_policy" {
  name = "CodeDeployEC2AdditionalPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.bucket}", # Bucket ARN
          "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.bucket}/*" # Objects in the bucket
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codedeploy_ec2_additional_policy_attach" {
  role       = aws_iam_role.codedeploy_ec2_role.name
  policy_arn = aws_iam_policy.codedeploy_ec2_additional_policy.arn
}

