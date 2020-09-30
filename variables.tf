variable "name" {
  description = "Name value for resources"
  type        = string
  default     = "Cloudfront-SG-Updater"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
