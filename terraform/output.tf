output "bob_secret" {
  value = "${aws_iam_access_key.developer_bob_access_key.secret}"
  sensitive = true
}
output "bob_keyid" {
  value = "${aws_iam_access_key.developer_bob_access_key.id}"
}