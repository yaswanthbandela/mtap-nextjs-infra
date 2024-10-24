output "ec2_public_ip" {
  value = aws_instance.mtap_nextjs_server.public_ip
}

output "s3_bucket" {
  value = var.s3_bucket_name != "" ? var.s3_bucket_name : "codepipeline-default-bucket"
}

output "pipeline_name" {
  value = aws_codepipeline.mtap_nextjs_pipeline.name
}

output "deploymentgroup_name" {
  value = element(split("/", aws_codedeploy_deployment_group.mtap_nextjs_deploy_dg.arn ), 1)
}

output "codedeploy_name" {
  value = aws_codedeploy_app.mtap_nextjs_deploy.name
}

output "bucket_name" {
  value = aws_s3_bucket.codepipeline_bucket.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.codepipeline_bucket.id
}