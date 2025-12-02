provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "ps_s3_bucket" {

  bucket = "ps-s3-bucket-ps-ps"

  tags = {
    Name        = "Poovarasan"
    Environment = "Demo"
  }

}

