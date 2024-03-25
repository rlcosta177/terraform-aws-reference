variable "ubuntu_ami" {
  type        = string
  default     = "ami-080e1f13689e07408"
  description = "description"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}