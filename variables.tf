variable "name" {
  type        = string
  description = "name of the bucket is determined based this varibale"
}
variable "acm" {
  type        = string
  description = "The issued certificate arn in certificate manager"
}
variable "domain" {
  type        = list(string)
  default     = null
  description = "This value is to be passed as a list even though only one domain"
}
variable "root_object" {
  type        = string
  default     = "index.html"
  description = "document root of website"
}