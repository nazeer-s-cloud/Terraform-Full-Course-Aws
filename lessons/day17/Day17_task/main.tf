resource "aws_iam_role" "eb_ec2_role" {
  name               = "${var.app_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.eb_ec2_assume_role_policy.json
  
  tags = var.tags
}

resource "aws_iam_policy_attachment" "eb_web_tier" {
    name       = "${var.app_name}-web-tier-attachment"
    roles      = [aws_iam_role.eb_ec2_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"  
}

resource "aws_iam_role_policy_attachment" "eb_worker_tier" {
    role       = aws_iam_role.eb_ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
  
}

resource "aws_iam_role_policy_attachment" "ec_multicontainer_docker" {
    role       = aws_iam_role.eb_ec2_role.name
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
  
}

resource "aws_iam_instance_profile" "eb_ec2_profile" {
  name = "${var.app_name}-eb-ec2-profile"
  role = aws_iam_role.eb_ec2_role.name

  tags = var.tags
}

resource "aws_iam_role" "eb_service_role" {
  name               = "${var.app_name}-service-role"
  assume_role_policy = data.aws_iam_policy_document.eb_service_assume_role_policy.json

  tags = var.tags
  
}

resource "aws_iam_role_policy_attachment" "eb_service_health" {
    role       = aws_iam_role.eb_service_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}   

resource "aws_iam_role_policy_attachment" "eb_service_managed_updates" {
    role       = aws_iam_role.eb_service_role.name
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
  
}

resource "aws_elastic_beanstalk_application" "app" {
    name        = var.app_name
    description =  "Blue-Green Deployment Demo Application"
    
    tags = var.tags
  
}

resource "aws_s3_bucket" "app_versions" {
    bucket = "${var.app_name}-versions-${data.aws_caller_identity.current.account_id}"
    
    tags = var.tags
  
}

resource "aws_s3_bucket_public_access_block" "app_versions_block" {
    bucket = aws_s3_bucket.app_versions.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  

}

data "aws_iam_policy_document" "eb_ec2_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "eb_service_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }
  }
}

data "aws_caller_identity" "current" {}
    





