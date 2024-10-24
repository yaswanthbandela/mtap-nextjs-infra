# AWS region
region = "us-east-1"

# AWS Account ID
account_id = "484907490966"

# VPC ID where the EC2 instance will be deployed
vpc_id = "vpc-0382bcc1a39154f0a"

# Instance type for EC2
instance_type = "t3.small"

# Amazon Machine Image (AMI) ID for EC2 instance
ami_id = "ami-0866a3c8686eaeeba"

# Key name for EC2 instance SSH access
key_name = "mylinuxserver"

# Name of the CodePipeline
pipeline_name = "mtap-nextjs-pipeline"

# S3 bucket for storing CodePipeline artifacts
s3_bucket_name = ""  # Use default if left empty

# Value for the EC2 tag filter in CodeDeploy
ec2_tag_value = "mtap-nextjs-server"

# GitHub Personal Access Token (secure this)
github_token = ""

# GitHub repository name
github_repo = "yaswanthbandela/mtap-nextjs"

# Branch to pull from GitHub
github_branch = "main"

# CodeStar connection ARN
codestar_connection_arn = "arn:aws:codestar-connections:us-east-1:484907490966:connection/50946584-428b-403c-a897-9e00f7e297b3"

# Domain name for NGINX server
domain_name = "test.byklabs.store"