data "aws_ecr_image" "lambda_image" {
  depends_on = [
    null_resource.lambda_image
  ]

  repository_name = aws_ecr_repository.lambda_repo.name
  image_tag       = var.docker_image_tag
}

resource "null_resource" "lambda_image" {
  triggers = {
    source_file = md5(file("../src/main.go"))
    docker_file = md5(file("../Dockerfile"))
  }

  provisioner "local-exec" {
    command = <<EOF
           cd ../
           aws ecr get-login-password --region ${var.region} | \
            docker login \
            --username AWS \
            --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
           docker build -t ${aws_ecr_repository.lambda_repo.repository_url}:${var.docker_image_tag} .
           docker push ${aws_ecr_repository.lambda_repo.repository_url}:${var.docker_image_tag}
       EOF
  }
}

resource "aws_ecr_repository" "lambda_repo" {
  name = var.lambda_name
}

output "ecr_url" {
  value = aws_ecr_repository.lambda_repo.repository_url
}
