// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("../keys/sa.json")}"
  project     = "bnc-pso-poc"
  region      = "us-central1"
}

#module "child" {
#  source = "./child"
#}
module "vpc" {
    #source = "terraform-google-modules/network/google"
    source = "../Modules/terraform-google-network"
    project_id   = "bnc-pso-poc"
    network_name = "example-vpc"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-west1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-west1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
        },
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]

        subnet-02 = []
    }
        routes = [
        {
            name                   = "egress-internet"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        },
    ]        
}
