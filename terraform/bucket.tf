resource "aws_s3_bucket" "datenablage-allgemein" {
  bucket = "datenablage-allgemein"
  tags = local.tags
}

resource "aws_s3_bucket_acl" "datenablage-allgemein-acl" {
  bucket = aws_s3_bucket.datenablage-allgemein.id
  acl    = "private"
}