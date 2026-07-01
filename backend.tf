terraform {
  backend "s3" {
    bucket         = "terraform-eks-custom-state-834948576227"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-eks-custom-locks"
    encrypt        = true
  }
}