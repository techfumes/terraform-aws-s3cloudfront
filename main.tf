resource "aws_s3_bucket" "s3-bucket" {
  bucket = var.name
}

resource "aws_s3_bucket_acl" "s3-bucket" {
  bucket = aws_s3_bucket.s3-bucket.id
  acl    = "private"
}



data "aws_iam_policy_document" "s3-bucket" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3-bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.s3-bucket.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3-bucket.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "s3-bucket" {
  bucket = aws_s3_bucket.s3-bucket.id
  policy = data.aws_iam_policy_document.s3-bucket.json
}


resource "aws_cloudfront_origin_access_identity" "s3-bucket" {
  comment = "origin identity for ${var.name}"
}

resource "aws_cloudfront_distribution" "s3-bucket" {
  origin {
    domain_name = aws_s3_bucket.s3-bucket.bucket_regional_domain_name
    origin_id   = var.name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.s3-bucket.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.root_object
  wait_for_deployment = false
  aliases             = var.domain

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.name
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  custom_error_response {
    error_code         = 404
    response_page_path = "/index.html"
    response_code      = 200
  }


  viewer_certificate {
    acm_certificate_arn = var.acm
    ssl_support_method  = "sni-only"

  }
}