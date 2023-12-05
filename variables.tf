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