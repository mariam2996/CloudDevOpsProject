resource "aws_ecr_repository" "frontend" {
  name = "${lower(var.project_name)}-frontend"
}

resource "aws_ecr_repository" "auth" {
  name = "${lower(var.project_name)}-auth-service"
}

resource "aws_ecr_repository" "roadmap" {
  name = "${lower(var.project_name)}-roadmap-service"
}
