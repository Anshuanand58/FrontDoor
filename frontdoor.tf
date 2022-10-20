# Azurerm Provider configuration

module "frontdoor" {
  source = "C:/Terraform/frontdoor/test"


  # By default, this module will not create a resource group. Location will be same as existing RG.
  # proivde a name to use an existing resource group, specify the existing resource group name, 
  # set the argument to `create_resource_group = true` to create new resrouce group.
  # resource_group_name = "rg-shared-westeurope-01"
  #  location            = "westeurope"
  frontdoor_name = "example-frontdoor51"

  routing_rules = [
    {
      name               = "exampleRoutingRule1"
      accepted_protocols = ["Http", "Https"]
      patterns_to_match  = ["/*"]
      frontend_endpoints = ["exampleFrontendEndpoint1"]
      forwarding_configuration = {
        forwarding_protocol = "MatchRequest"
        backend_pool_name   = "exampleBackendBing"
      }
    }
  ]

  backend_pool_load_balancing = [
    {
      name = "exampleLoadBalancingSettings1"
    }
  ]

  backend_pool_health_probes = [
    {
      name = "exampleHealthProbeSetting1"
    }
  ]

  backend_pools = [
    {
      name = "exampleBackendBing"
      backend = {
        host_header = "www.bing.com"
        address     = "www.bing.com"
        http_port   = 80
        https_port  = 443
      }
      load_balancing_name = "exampleLoadBalancingSettings1"
      health_probe_name   = "exampleHealthProbeSetting1"
    }
  ]

  # In order to enable the use of your own custom HTTPS certificate you must grant  
  # Azure Front Door Service access to your key vault. For instuctions on how to  
  # configure your Key Vault correctly. Please refer to the product documentation.
  # https://bit.ly/38FuAZv

  frontend_endpoints = [
    {
      name      = "exampleFrontendEndpoint1"
      host_name = "example-frontdoor51.azurefd.net"
      session_affinity_enabled = false
      session_affinity_ttl_seconds = 0
    }
  ]
  

  # (Optional) To enable Azure Monitoring for Azure Frontdoor
  # (Optional) Specify `storage_account_name` to save monitoring logs to storage. 
  # log_analytics_workspace_name = "loganalytics-we-sharedtest2"
}