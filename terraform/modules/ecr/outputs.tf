output "frontend_repository_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "auth_repository_url" {
  value = aws_ecr_repository.auth.repository_url
}

output "roadmap_repository_url" {
  value = aws_ecr_repository.roadmap.repository_url
}
