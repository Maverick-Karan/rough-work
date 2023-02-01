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
}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
	  "Principal": "*",
      "Action": [ "s3:*" ],
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }
  ]
}
EOF
}


resource "aws_s3_object" "object" {
  bucket = "test21121007"
  key    = "buddha.jpg"
  source = "./buddha.jpg"
  content_type = "image/jpeg"
  etag = filemd5("./buddha.jpg")

  depends_on = [aws_s3_bucket.bucket]
}

resource "aws_s3_object" "index" {
  bucket = "test21121007"
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
  etag = filemd5("./index.html")

  depends_on = [aws_s3_bucket.bucket]
}
