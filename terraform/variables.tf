variable "region" {}
variable "aws_access_key" {}


variable "cidr_block" {}

variable "aws_secret_key" {}


variable "environment" {
  default     = "DEV"
  description = "Describe environment"
}
variable "project" {
  default     = "DEV"
  description = "Describe environment"
}

variable "product" {
  default     = "DEV"
  description = "Describe environment"
}

variable "vpc_id" {
  default     = "DEV"
  description = "Describe environment"
}

variable "availabilityZone" {
  default = [
    
  ]
  type = "list"
}



variable "ami" {}

variable "key_name" {}

#variable "privateSubnetsDomain" {}


variable "public_subnets" {
  default = [
   ]
  type = "list"
}

variable "num_subnets" {
  default = {
    public     = "1"
  }
  type = "map"
}

variable "private_subnets" {
  default = [
    
  ]
  type = "list"
}


variable "public_subnets_ids" {
  default = [
    
  ]
  type = "list"
}


variable "jumphostIPs" {
  default = [
    
  ]
  type = "list"
}


variable "prometheusIPs" {
  default = [
    
  ]
  type = "list"
}

variable "zookeeperIPs" {
  default = [
    
  ]
  type = "list"
}


variable "logstashIPs" {
  default = [
    
  ]
  type = "list"
}


variable "kafkaIPs" {
  default = [
    
  ]
  type = "list"
}
variable "schema_registryIPs" {
  default = [
    
  ]
  type = "list"
}

variable "kafka_connectIPs" {
  default = [
    
  ]
  type = "list"
}


variable "num_instances" {
  default = {
    zookeeper     = "1"
  }
  type = "map"
}



variable "instance_types" {
  default = {
    zookeeper     = "1"
  }
  type = "map"
}


variable "azsDomain" {
   default = [
    "AZ_1",
    "AZ_2",
    "AZ_3",
   ]

  type = "list"
}
