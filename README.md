# terraform-aws-s3cloudfront
Terraform module to create a s3 with cloudfront website site 




## Usage EXAMPLE
```
module "mystaticwebsite" {
  source      = "techfumes/s3cloudfront/aws"
  name        = "mywebsite-prod"
  acm         = "arn:aws:acm:us-east-1:555555555555:certificate/475098e5-7359-42ff-807b-b643d8ce6d54"
  domain      = ["example.com", "www.example.com"]
}
```

Check valid versions on:
* Github Releases: <https://github.com/techfumes/terraform-aws-s3cloudfront/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/techfumes/s3cloudfront/aws/latest>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="name"></a> [name](#input\_name) |  "example-prod" usually that's how I name resources. example could be our project name and in this module, we name things as environment+name so if our project name is example then we provide name variable as adminpanel then the resources will be named as example-prod-backend | string | yes |
| <a name="acm"></a> [acm](#input\_acm) | This should be a issued Aws certificate manager certificate arn that is in North virgina(us-east-1) region | string | yes |
| <a name="domain"></a> [domain](#input\_domain) | This should be a issued Aws certificate manager certificate arn that is in North virgina(us-east-1) region | list(string) | yes |
| <a name="root_object"></a> [root_object](#input\_root_object) | This is the document root of website | string | no |

## Authors

Module is maintained by [Anil Augustine Chalissery](https://github.com/anilchalissery) 

## License

Apache 2 Licensed. See [LICENSE](https://github.com/techfumes/terraform-aws-s3cloudfront/tree/master/LICENSE) for full details.

