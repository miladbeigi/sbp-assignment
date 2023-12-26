variable "bucket-name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "topic-name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "email" {
  description = "The email address to subscribe to the SNS topic"
  type        = string
}
