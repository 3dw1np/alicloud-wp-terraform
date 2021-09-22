variable "name" {
  description = "Solution Name"
  default = "wp_app"
}

variable "cidr" {
  description = "CIDR range to use for the VPC"
  default = "192.168.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use"
  default = 2
}

variable "ecs_type" {
  description = "Sizing of VM ECS"
  default = "ecs.t6-c1m2.large"
}

variable "ecs_image_name" {
  description = "Name of base image OS"
  default = "ubuntu_20_04_x64_20G_alibase_20210824.vhd"
}

variable "vm_count" {
  description = "Number of VMs to use"
  default = 1
}

variable "rds_type" {
  description = "Sizing of DB instance"
  default = "mysql.n2.medium.25"
}

variable "ssh_password" {
  description = "Ssh password for the VMs"
}
