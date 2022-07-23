terraform {
  required_providers {
    pingone = {
      source  = "pingidentity/pingone"
      version = "~> 0.1"
    }
  }
}

provider "pingone" {
  client_id      = var.p1_adminClientId
  client_secret  = var.p1_adminClientSecret
  environment_id = var.p1_adminEnvId
  region         = var.p1_region

  force_delete_production_type = false
}

resource "pingone_environment" "my_environment" {
  name        = "New Environment"
  description = "My new environment"
  type        = "SANDBOX"
  region      = var.p1_region
  license_id  = var.p1_licenseId

  default_population {
    name        = "My Population"
    description = "My new population for users"
  }

  service {
    type = "SSO"
  }

  service {
    type        = "PingFederate"
    console_url = "https://my-pingfederate-console.example.com/pingfederate"
  }
}

resource "pingone_population" "my_population" {
  environment_id = pingone_environment.my_environment.id

  name        = "My second population"
  description = "My new population"
}

resource "pingone_group" "my_group" {
  environment_id = pingone_environment.my_environment.id

  name        = "My group"
  description = "My new group"
}
