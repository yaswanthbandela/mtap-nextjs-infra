variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be deployed"
  default     = "vpc-0fc43d82243033d68"
}

variable "instance_type" {
  description = "Instance type for EC2"
  default     = "t3.small"
}

variable "ami_id" {
  description = "Amazon Machine Image (AMI) ID for EC2 instance"
  default     = "ami-0866a3c8686eaeeba"  # Replace with an AMI ID of your choice
}

variable "key_name" {
  description = "Key name for EC2 instance SSH access"
  default     = "mylinuxserver"
}

variable "pipeline_name" {
  description = "Name of the CodePipeline"
  default     = "mtap-nextjs-pipeline"
}

variable "s3_bucket_name" {
  description = "S3 bucket for storing CodePipeline artifacts"
  default     = ""  # Leave blank to use the default bucket provided by CodePipeline
}

variable "ec2_tag_value" {
  description = "Value for the EC2 tag filter in codeDeploy"
  default     = "mtap-nextjs-server"  # You can update this if needed
}


variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "github_repo" {
  description = "GitHub repository name"
  default     = "hureka/mtap-nextjs"  # Replace with your GitHub repo name
}

variable "github_branch" {
  description = "Branch to pull from GitHub"
  default     = "main"
}

