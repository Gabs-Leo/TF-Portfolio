//_______________PROJECT_______________//
variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "environment" {
  type = string
}

//_______________Database_______________//
variable "databaseVersion" {
  type = string
}
variable "databaseTier" {
  type = string
}

//_______________VPC_______________//
variable "subnetPublicCidrs" {
  type = list(string)
}
variable "subnetPrivateCidrs" {
  type = list(string)
}