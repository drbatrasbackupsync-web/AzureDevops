rgs = {
  rg1 = {
    name     = "rg-chor-prod"
    location = "centralindia"
  }
}

vnets = {
  vnet1 = {
    name                = "vnet-chor-prod"
    location            = "centralindia"
    resource_group_name = "rg-chor-prod"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  snet1 = {
    name                 = "agw-subnet"
    resource_group_name  = "rg-chor-prod"
    virtual_network_name = "vnet-chor-prod"
    address_prefixes     = ["10.0.1.0/24"]
  },
  snet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "rg-chor-prod"
    virtual_network_name = "vnet-chor-prod"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

nsgs = {
  nsg1 = {
    name                = "nsg-agw-prod"
    resource_group_name = "rg-chor-prod"
    location            = "centralindia"
    security_rules = [
      {
        name                       = "Allow-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allow-HTTPS"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

public_ips = {
  pip1 = {
    name                = "pip-agw-prod"
    resource_group_name = "rg-chor-prod"
    location            = "centralindia"
    allocation_method   = "Static"
    sku                 = "Standard"
    tags = {
      environment = "prod"
    }
  }
}

nics = {
  nic1 = {
    name                  = "nic-web-prod-01"
    resource_group_name   = "rg-chor-prod"
    location              = "centralindia"
    ip_configuration_name = "ipconfig1"
    subnet_key            = "snet2"
    tags = {
      environment = "prod"
    }
  }
}

key_vaults = {
  kv1 = {
    name                      = "kv-chor-prod-01"
    resource_group_name       = "rg-chor-prod"
    location                  = "centralindia"
    sku_name                  = "standard"
    enable_rbac_authorization = true
    tags = {
      environment = "prod"
    }
  }
}

storage_accounts = {
  sa1 = {
    name                     = "stchorprod01"
    location                 = "centralindia"
    resource_group_name      = "rg-chor-prod"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

application_gateways = {
  agw1 = {
    name                = "agw-chor-prod"
    resource_group_name = "rg-chor-prod"
    location            = "centralindia"
    sku = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 2
    }
    gateway_ip_configuration = {
      name       = "agw-ip-config"
      subnet_key = "snet1"
    }
    frontend_ports = [
      {
        name = "http-port"
        port = 80
      }
    ]
    frontend_ip_configurations = [
      {
        name          = "agw-frontend-ip"
        public_ip_key = "pip1"
      }
    ]
    backend_address_pools = [
      {
        name         = "backend-pool-prod"
        ip_addresses = ["10.0.2.10", "10.0.2.11"]
      }
    ]
    backend_http_settings = [
      {
        name                  = "http-settings"
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
      }
    ]
    http_listeners = [
      {
        name                           = "http-listener"
        frontend_ip_configuration_name = "agw-frontend-ip"
        frontend_port_name             = "http-port"
        protocol                       = "Http"
      }
    ]
    request_routing_rules = [
      {
        name                       = "rule-http"
        rule_type                  = "Basic"
        http_listener_name         = "http-listener"
        backend_address_pool_name  = "backend-pool-prod"
        backend_http_settings_name = "http-settings"
        priority                   = 100
      }
    ]
    tags = {
      environment = "prod"
    }
  }
}
