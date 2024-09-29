

run "bucket_name_is_valid" {

  command = apply

  variables {
    environment = "dev"
    bucket_files = {
      "test_file1.txt" = "test_content1"
      "test_file2.txt" = "test_content2"
      "test_file3.txt" = "test_content3"
    }
  }

  assert {
    condition     = strcontains(aws_s3_bucket.bucket.bucket, "bucket-test-terraform-${var.environment}")
    error_message = "S3 bucket name did not match expected"
  }

  assert {
    condition     = length(aws_s3_object.files) == 3
    error_message = "Invalid S3 objects count"
  }

  assert {
    condition = anytrue([
      #Iteramos sobre el conjunto rule
      for rule in aws_s3_bucket_server_side_encryption_configuration.bucket_encryption.rule :

      #Si la rule es apply_server_side_encryption_by_default iteramos sobre ella buscando el
      #atributo sse_algorithm, en caso contrario retornamos false
      rule.apply_server_side_encryption_by_default != null ?
      anytrue([for sse_config in rule.apply_server_side_encryption_by_default : sse_config.sse_algorithm == "AES256"]) : false
    ])

    error_message = "Dev bucket is not using the right encryption"
  }

}