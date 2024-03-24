terraform {
  backend "s3" {
    bucket = "cyberspeed-tfstate-bucket"
    key    = "eks/terraform.tfstate"
    region = "us-west-2"
  }
}


