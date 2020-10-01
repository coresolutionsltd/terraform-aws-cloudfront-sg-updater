[![alt text](https://coresolutions.ltd/media/core-solutions-82.png "Core Solutions")](https://coresolutions.ltd)

[![maintained by Core Solutions](https://img.shields.io/badge/maintained%20by-coresolutions.ltd-00607c.svg)](https://coresolutions.ltd)
[![GitHub tag](https://img.shields.io/github/v/tag/coresolutions-ltd/terraform-aws-cloudfront-sg-updater.svg?label=latest)](https://github.com/coresolutions-ltd/terraform-aws-cloudfront-sg-updater/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12-623ce4.svg)](https://github.com/hashicorp/terraform/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

# Cloudfront SG Updater Terraform Module

A Terraform module to automatically update Security Group ingress rules with the latest public Cloudfront IP ranges.

This module is based on this [AWS blog post](https://aws.amazon.com/blogs/security/how-to-automatically-update-your-security-groups-for-amazon-cloudfront-and-aws-waf-by-using-aws-lambda/), see the original blog post for steps on how to test the lambda function.

The lambda function uses tags to identify security groups it needs to update, the following are the three required tags:

| key        | value                            |
| ---------- | -------------------------------- |
| Name       | `cloudfront_g` or `cloudfront_r` |
| AutoUpdate | true                             |
| Protocol   | `http` or `https`                |

> Note you may need to [increase your SG rule quota](https://aws.amazon.com/premiumsupport/knowledge-center/increase-security-group-rule-limit/) if you have not done so previously.

## Getting Started

```sh
module "cloudfront-sg-updater" {
    source  = "coresolutions-ltd/cloudfront-sg-updater/aws"
    version = "~> 0.0.2"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Providers

| Name | Version |
| ---- | ------- |
| aws  | ~> 3.0  |

## Inputs

| Name | Description              | Type          | Default                   | Required |
| ---- | ------------------------ | ------------- | ------------------------- | :------: |
| name | Name value for resources | `string`      | `"Cloudfront-SG-Updater"` |    no    |
| tags | Resource tags            | `map(string)` | `{}`                      |    no    |

## Outputs

| Name       | Description |
| ---------- | ----------- |
| lambda_arn | n/a         |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
