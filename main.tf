resource "aws_route53_record" "www" {
  count = length(local.csv_data)
  zone_id = var.dns_zone
  name    = local.csv_data[count.index].record_name
  type    = "A"
  ttl     = "300"
  records = [local.csv_data[count.index].ip]
}

data "local_file" "my_csv" {

    filename = "my_csv.csv"

}

locals {
    csv_data = csvdecode(data.local_file.my_csv.content)
    dns_zone = "test.com"
}

variable "dns_zone" {
  description = "a fancy dns zone"
  default = "test.com"
  type = string
}

provider "aws" {
  region = "ca-central-1"
}


