output "ec2_public_ip" {
  value = aws_instance.mtap_nextjs_server.public_ip
}

output "s3_bucket" {
  value = var.s3_bucket_name != "" ? var.s3_bucket_name : "codepipeline-default-bucket"
}

output "pipeline_name" {
  value = aws_codepipeline.mtap_nextjs_pipeline.name
}
