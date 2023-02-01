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
  policy = data.aws_iam_policy_document.access-policy.json
}

data "aws_iam_policy_document" "access-policy" {
  statement {
     actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}


