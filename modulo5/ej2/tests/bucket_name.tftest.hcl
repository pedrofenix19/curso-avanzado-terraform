mock_provider "aws" {}
override_module {
    target = module.ec2_instances
    outputs = {
        instance_ips = {
            "i-1111111111" = "ip1"
            "i-2222222222" = "ip2"
        }
    }
}

run "test_file_count" {
    command = plan

    assert {
        condition = length(aws_s3_object.public_ip_files) == 2
        error_message = "Number of created files is invalid"
    }

    assert {
        condition = alltrue([
        for instance_id, ip in module.ec2_instances.instance_ips : 
        aws_s3_object.public_ip_files[instance_id].key == "${instance_id}.txt" && 
        aws_s3_object.public_ip_files[instance_id].content == ip
      ])
       error_message = "The objects are not created properly"
    }
}