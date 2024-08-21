variable "num" {
  type        = number
  default     = 1
  description = "Number of lxd containers to be created."
}

variable "image" {
  type        = string
  default     = "ubuntu:24.04"
  description = "The image for the lxd containers."
}

variable "cpu" {
  type        = number
  default     = 1
  description = "The number of cpu cores for each lxd container."
}

variable "memory" {
  type        = string
  default     = "1GiB"
  description = "The amount of memory for each lxd container."
}

variable "auth_key" {
  type        = string
  nullable    = false
  sensitive   = true
  description = "The auth key used by tailscale to add a device (Required)."
  validation {
    condition     = length(var.auth_key) > 0
    error_message = "The auth_key cannot be empty string."
  }
}
