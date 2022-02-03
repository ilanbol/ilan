output "ami_id" {
  value = data.aws_ssm_parameter.this.value
}