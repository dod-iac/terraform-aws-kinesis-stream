variable "encryption_type" {
  type        = string
  description = "The encryption type to use. The only acceptable values are NONE or KMS."
  default     = "KMS"
}

variable "enforce_consumer_deletion" {
  type        = bool
  description = "A boolean that indicates all registered consumers should be deregistered from the stream so that the stream can be destroyed without error."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "The GUID for the customer-managed KMS key to use for encryption. You can also use a Kinesis-owned master key by specifying the alias alias/aws/kinesis."
  default     = "alias/aws/kinesis"
}

variable "name" {
  type        = string
  description = "A name to identify the stream. This is unique to the AWS account and region the Stream is created in."
}

variable "retention_period" {
  type        = number
  description = "Length of time data records are accessible after they are added to the stream."
  default     = 24
}

variable "shard_count" {
  type        = number
  description = "The number of shards that the stream will use."
  default     = 1
}

variable "shard_level_metrics" {
  type        = list(string)
  description = "A list of shard-level CloudWatch metrics which can be enabled for the stream."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the Kinesis stream."
  default     = {}
}
