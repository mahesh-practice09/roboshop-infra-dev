locals {
  CachingDisabled = data.aws_cloudfront_cache_policy.cachedisabled.id
  CachingOptimized = data.aws_cloudfront_cache_policy.cacheoptimized.id
  acm_certificate_arn = data.aws_ssm_parameter.roboshop_arn.value
   common_tags = {
        Project = var.Project
        Terraform = true
        Env = var.environment
      }
}