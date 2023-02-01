##############################################################################################
#Create S3 bucket, upload objects
resource "aws_s3_bucket" "bucket" {
   bucket = "test21121007"
   tags = {
      description = "Testing"
   }
}

resource "aws_s3_object" "object" {
  bucket = "test21121007"
  key    = "buddha.jpg"
  source = "./buddha.jpg"
  etag = filemd5("./buddha.jpg")

  depends_on = [aws_s3_bucket.bucket]
}

resource "aws_s3_object" "index" {
  bucket = "test21121007"
  key    = "index.html"
  source = "./index.html"
  etag = filemd5("./buddha.jpg")

  depends_on = [aws_s3_bucket.bucket]
}



