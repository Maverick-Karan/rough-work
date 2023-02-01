##############################################################################################
#Create S3 bucket, upload objects
resource "aws_s3_bucket" "bucket" {
   bucket = "test21121007"
   tags = {
      description = "Testing"
   }
}

resource "aws_s3_bucket_website_configuration" "website-config" {
  bucket = aws_s3_bucket.bucket.bucket
  index_document {
       suffix = "index.html"
  }
  error_document {
       key = "404.jpeg"
  }
}

resource "aws_s3_bucket_policy" "public-access" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<EOF {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::test21121007",
            "Principal": "*"
          }
        ]
  } EOF
}

