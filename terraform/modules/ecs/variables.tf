variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "service_name" {
  description = "The service name of the ECS cluster."
  type        = string
}

variable "task_family" {
  description = "The name of the task definition family."
  type        = string
}

variable "cpu" {
  description = "The amount of CPU units to reserve for the task."
  type        = string
  default     = "256"
}

variable "memory" {
  description = "The amount of memory (in MiB) to reserve for the task."
  type        = string
  default     = "512"
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
  type        = string
  default     = "256"
}

variable "container_memory" {
  description = "The amount of memory (in MiB) to reserve for the container."
  type        = string
  default     = "512"
}

variable "container_port" {
  description = "The port the container will listen on."
  type        = number
  default     = 8080
}

variable "postgres_host" {
  description = "The hostname of the PostgreSQL database."
  type        = string
}

variable "postgres_port" {
  description = "The port of the PostgreSQL database."
  type        = string
  default     = "5432"
}

variable "postgres_user" {
  description = "The username for the PostgreSQL database."
  type        = string
}

variable "postgres_password" {
  description = "The password for the PostgreSQL database."
  type        = string
}

variable "postgres_db" {
  description = "The name of the PostgreSQL database."
  type        = string
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

variable "target_group_arn" {
  description = "The ARN of the target group for the load balancer."
  type        = string
}