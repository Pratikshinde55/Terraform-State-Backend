
########.............Terraform-login block.........#############

terraform {
  required_version = "~>1.2"

###remote backend - aws "S3" bucket..............

  backend "s3" {
    bucket         = "tf-ps"
    key            = "webdev/my.state"
    region         = "ap-south-1"
    dynamodb_table = "table-locking-statefile"
  }

 ######... Plugin-info-aws.........

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.42.0"
    }
  }
}

###### Region and credentials........

provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}
