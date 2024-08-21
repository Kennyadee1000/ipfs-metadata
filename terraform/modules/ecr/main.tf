resource "aws_ecr_repository" "ecs_repo" {

  name = var.ecr_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = var.tags

}

resource "null_resource" "force_delete_ecr_images" {
  triggers = {
    ecr_repo_name = aws_ecr_repository.ecs_repo.name
  }

  provisioner "local-exec" {
    command = <<EOT
      aws ecr list-images --repository-name ${aws_ecr_repository.ecs_repo.name} --query 'imageIds[*]' --output json --profile ${var.environment} | \
      jq '. | map({"imageDigest": .imageDigest})' | \
      jq -c '.[]' | \
      while read image; do
        aws ecr batch-delete-image --repository-name ${aws_ecr_repository.ecs_repo.name} --profile ${var.environment} --image-ids "$image" ;
      done
    EOT
  }

  depends_on = [aws_ecr_repository.ecs_repo]
}