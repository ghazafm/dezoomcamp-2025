variable "region" {
  default = "ap-southeast-3"
}

variable "zone" {
  default = "ap-southeast-3a"
}

variable "amiID" {
  type = map(any)
  default = {
    ap-southeast-1 = "ami-0672fd5b9210aa093"
    ap-southeast-2 = "ami-09e143e99e8fa74f9"
    ap-southeast-3 = "ami-0d22ac6a0e117cefe"
  }
}

variable "webuser" {
  default = "ubuntu"
}
