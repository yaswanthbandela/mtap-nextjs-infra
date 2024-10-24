variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "account_id" {
  description = "aws account id"
  default     = "484907490966"
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be deployed"
  default     = "vpc-0382bcc1a39154f0a"
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
}

variable "github_repo" {
  description = "GitHub repository name"
  default     = "yaswanthbandela/mtap-nextjs"  # Replace with your GitHub repo name
}

variable "github_branch" {
  description = "Branch to pull from GitHub"
  default     = "main"
}

variable "codestar_connection_arn" {
  description = "code star connection arn"
  default     = "arn:aws:codestar-connections:us-east-1:484907490966:connection/50946584-428b-403c-a897-9e00f7e297b3"
}
