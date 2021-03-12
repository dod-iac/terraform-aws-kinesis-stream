<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates a Kinesis stream encrypted using the AWS-managed KMS key.

```hcl
module "kinesis_stream" {
  source = "dod-iac/kinesis-stream/aws"

  name = format("app-%s-%s", var.application, var.environment)
  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

Creates a Kinesis stream encrypted using a customer-managed KMS key.

```hcl
module "kinesis_kms_key" {
  source = "dod-iac/kinesis-kms-key/aws"

  name = format("alias/app-%s-kinesis-%s", var.application, var.environment)
  description = format("A KMS key used to encrypt Kinesis stream records at rest for %s:%s.", var.application, var.environment)
  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}

module "kinesis_stream" {
  source = "dod-iac/kinesis-stream/aws"

  name = format("app-%s-%s", var.application, var.environment)
  kms_key_id = module.kinesis_kms_key.aws_kms_key_arn
  tags = {
    Application = var.application
    Environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) |
| [aws_kinesis_stream](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream) |
| [aws_partition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| encryption\_type | The encryption type to use. The only acceptable values are NONE or KMS. | `string` | `"KMS"` | no |
| enforce\_consumer\_deletion | A boolean that indicates all registered consumers should be deregistered from the stream so that the stream can be destroyed without error. | `bool` | `true` | no |
| kms\_key\_id | The GUID for the customer-managed KMS key to use for encryption. You can also use a Kinesis-owned master key by specifying the alias alias/aws/kinesis. | `string` | `"alias/aws/kinesis"` | no |
| name | A name to identify the stream. This is unique to the AWS account and region the Stream is created in. | `string` | n/a | yes |
| retention\_period | Length of time data records are accessible after they are added to the stream. | `number` | `24` | no |
| shard\_count | The number of shards that the stream will use. | `number` | `1` | no |
| shard\_level\_metrics | A list of shard-level CloudWatch metrics which can be enabled for the stream. | `list(string)` | `[]` | no |
| tags | Tags applied to the Kinesis stream. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the Kinesis stream |
| name | The name of the Kinesis stream |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
