resource "aws_s3_bucket" "datenablage-allgemein" {
  bucket = "datenablage-allgemein"
  acl    = "private"

  tags = local.tags
}