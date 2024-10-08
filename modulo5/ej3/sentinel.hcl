import "static" "software_inventory" {
  source = "./software_inventory/software_inventory.json"
  format = "json"
}

sentinel {
    features = {
        terraform = true
    }
}

import "plugin" "tfplan/v2" {
  config = {
    plan_path = "./plan.json"
  }
}

policy "valid_instance_type" {
    source = "./sentinel/standalone.sentinel"
    enforcement_level = "advisory"

    params = {
        instance_type = "t3.medium"
        instance_region = "us-east-1"
    }
}

policy "validate_std_imports" {
    source = "./sentinel/std_imports.sentinel"
}

policy "validate_json_import" {
    source = "./sentinel/json_import.sentinel"

    params = {
        terraform_min_version = "1.5.0"
        sentinel_min_version = "0.20"
    }
}

policy "http-public-ingress" {
  source            = "./sentinel/validate_terraform.sentinel"
  enforcement_level = "hard-mandatory"
}