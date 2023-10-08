resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.api.function_name}"
  retention_in_days = 1
}

resource "aws_lambda_function" "api" {
  depends_on = [
    null_resource.lambda_image
  ]

  function_name = var.lambda_name
  role          = aws_iam_role.lambda_role.arn
  timeout       = 300
  image_uri     = "${aws_ecr_repository.lambda_repo.repository_url}@${data.aws_ecr_image.lambda_image.id}"
  package_type  = "Image"
}

output "lambda_name" {
  value = aws_lambda_function.api.id
}
