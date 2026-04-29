data "aws_cloudfront_cache_policy" "cachedisabled" {
   name = "Managed-CachingDisabled"
}

data "aws_cloudfront_cache_policy" "cacheoptimized" {
   name = "Managed-CachingOptimized"
}

data "aws_ssm_parameter" "roboshop_arn" {
  name  = "/${var.Project}/${var.environment}/roboshop_arn"
}