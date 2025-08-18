variable "lt_name" {}
variable "asg_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "security_group_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "min_size" {}
variable "max_size" {}
variable "desired_capacity" {}
