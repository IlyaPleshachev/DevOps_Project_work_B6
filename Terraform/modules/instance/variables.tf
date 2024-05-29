variable "edu_instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "edu_instance_name" {
  description = "Instance name"
  type        = string
  default     = "noname"
}

variable "edu_vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "edu_instance_zone" {
  description = "Instance Zone"
  type        = string
}