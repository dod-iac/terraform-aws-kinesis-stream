/**
 * ## Usage
 *
 * Creates a Kinesis stream encrypted using the AWS-managed KMS key.
 *
 * ```hcl
 * module "kinesis_stream" {
 *   source = "dod-iac/kinesis-stream/aws"
 *
 *   name = format("app-%s-%s", var.application, var.environment)
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * Creates a Kinesis stream encrypted using a customer-managed KMS key.
 *
 * ```hcl
 * module "kinesis_kms_key" {
 *   source = "dod-iac/kinesis-kms-key/aws"
 *
 *   name = format("alias/app-%s-kinesis-%s", var.application, var.environment)
 *   description = format("A KMS key used to encrypt Kinesis stream records at rest for %s:%s.", var.application, var.environment)
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 *
 * module "kinesis_stream" {
 *   source = "dod-iac/kinesis-stream/aws"
 *
 *   name = format("app-%s-%s", var.application, var.environment)
 *   kms_key_id = module.kinesis_kms_key.aws_kms_key_arn
 *   tags = {
 *     Application = var.application
 *     Environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

resource "aws_kinesis_stream" "main" {
  enforce_consumer_deletion = var.enforce_consumer_deletion
  encryption_type           = var.encryption_type
  kms_key_id                = var.kms_key_id
  name                      = var.name
  retention_period          = var.retention_period
  shard_count               = var.shard_count
  shard_level_metrics       = length(var.shard_level_metrics) > 0 ? var.shard_level_metrics : null
  tags                      = var.tags
}
