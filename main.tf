resource "aws_s3_bucket" "bucket" {
   bucket = "test21121007"
   tags = {
      description = "Testing"
   }
}

output static-website {
   value = "http://${aws_s3_bucket.bucket.id}.s3-website-${var.region}.amazonaws.com"
}