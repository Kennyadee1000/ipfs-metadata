variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster."
  type        = string
}

variable "service_name" {
  description = "The service name of the ecs cluster."
  type        = string
}
variable "task_type" {
  description = "The type of task (e.g., app, db)."
  type        = string
}

variable "task_family" {
  description = "The name of the task definition family."
  type        = string
}

variable "cpu" {
  description = "The amount of CPU units to reserve for the task."
  type        = number
  default     = 256
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the task."
  type        = number
  default     = 512
}

variable "container_name" {
  description = "The name of the container."
  type        = string
}

variable "container_image" {
  description = "The Docker image to use for the container."
  type        = string
}

variable "container_cpu" {
  description = "The amount of CPU units to reserve for the container."
  type        = number
  default     = 0
}

variable "container_memory" {
  description = "The amount of memory (in MiB) to reserve for the container."
  type        = number
  default     = 128
}

variable "container_port" {
  description = "The port the container will listen on."
  type        = number
  default     = 80
}

variable "container_environment" {
  description = "The environment variables for the container."
  type        = list(map(string))
  default     = []
}

variable "desired_count" {
  description = "The number of desired tasks to run."
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "The IDs of the subnets where the ECS service will run."
  type        = list(string)
}

variable "security_group_id" {
  description = "The security group ID to assign to the ECS service."
  type        = string
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the ECS tasks."
  type        = bool
  default     = true
}

variable "enable_load_balancer" {
  description = "Whether to enable a load balancer for the ECS service."
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "The ARN of the target group for the load balancer."
  type        = string
  default     = ""
}

variable "execution_role_policy_arns" {
  description = "The ARNs of the managed policies to attach to the execution role."
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

variable "environment" {
  description = "The environment to deploy the ecs cluster."
  type        = string
}

variable "region" {
  description = "The region to deploy the ecs cluster."
  type        = string
}

variable "secrets" {
  description = "The cluster environment secret."
  type        = list(any)
  default     = []
}

variable "health_url" {
  description = "The ecs healthcheck path."
  type = string
}