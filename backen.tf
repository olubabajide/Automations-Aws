terraform {
  backend "s3" {
    bucket = "splunk-infra01"
    key = "habeeb"
  }
}