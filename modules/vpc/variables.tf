variable "project" {
  type = string
}
variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "subnetPrivateCidrs" {
  type = list(string)
}
variable "subnetPublicCidrs" {
  type = list(string)
}