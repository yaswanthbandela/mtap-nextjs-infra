resource "aws_codedeploy_app" "mtap_nextjs_deploy" {
  name = "mtap-nextjs-deploy"
}

resource "aws_codedeploy_deployment_group" "mtap_nextjs_deploy_dg" {
  app_name              = aws_codedeploy_app.mtap_nextjs_deploy.name
  deployment_group_name = "mtap-nextjs-deploy-dg"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = var.ec2_tag_value  
      type  = "KEY_AND_VALUE"
    }
  }

  auto_rollback_configuration {
    enabled = false
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
