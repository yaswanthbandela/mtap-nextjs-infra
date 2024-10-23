resource "aws_codebuild_project" "mtap_nextjs_build" {
  name          = "mtap-nextjs-build"
  description   = "Build project for MyApp"
  build_timeout = "5"

  source {
    type      = "CODEPIPELINE"  # Now using CodePipeline's GitHub artifact
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    environment_variable {
      name  = "ENV"
      value = "production"
    }
  }

  service_role = aws_iam_role.codebuild_role.arn
}
