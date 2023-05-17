terraform {
  required_version = ">= 0.15"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.30.0"
    }
  }
  backend "s3" {}
}

provider "linode" {
  token = var.linode_api_token
}

variable "linode_api_token" {
  description = "Linode API Personal Access Token (required)."
  sensitive   = true
}

resource "linode_lke_cluster" "terraform_k8s" {
  label       = "tf-k8s"
  k8s_version = "1.26"
  region      = "us-east"
  tags        = ["tf-k8s"]

  pool {
    type  = "g6-standard-1"
    count = 3
  }
}
