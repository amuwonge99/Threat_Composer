resource "aws_ecr_repository" "gatus" {
  name                 = "gatus"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "gatus"
    Environment = var.environment
  }
}

resource "aws_ecr_lifecycle_policy" "gatus" {
  repository = aws_ecr_repository.gatus.name

  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Keep last 5 images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 5
      }
      action = {
        type = "expire"
      }
    }]
  })
}