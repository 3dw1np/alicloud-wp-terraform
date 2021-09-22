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