variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "Deployment Region"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "Deployment Zone"
  type        = string
  default     = "asia-south1-a"
}
