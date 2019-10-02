variable "region" {
  type = "string"
  default = "us-east1"
}

variable "project_id" {
  type = "string"
  default = "XXXXXXXXXXXX"
}

#Monitoring Variables

variable "notification_email" {
  type = "string"
}

variable "log_monitoring" {
  description = "Configures log monitoring"
  default = []
  type = "list"
}