provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "ps_s3_bucket" {

  bucket = "ps-s3-bucket"

  tags = {
    Name        = "Poovarasan"
    Environment = "Demo"
  }

}

