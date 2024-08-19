resource "aws_s3_bucket" "terraform_s3_state" {
  bucket = var.state_bucket_name
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {

  bucket = aws_s3_bucket.terraform_s3_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_backend_configuration" {
  bucket = aws_s3_bucket.terraform_s3_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamo_lock_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}