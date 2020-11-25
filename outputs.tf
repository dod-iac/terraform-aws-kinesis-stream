output "arn" {
  description = "The ARN of the Kinesis stream"
  value       = aws_kinesis_stream.main.arn
}

output "name" {
  description = "The name of the Kinesis stream"
  value       = aws_kinesis_stream.main.name
}
