# Azure Environment
variable prefix { 
    description = "resource prefix"
    default = "bigiq-" 
}
variable "buildSuffix" {
  description = "resource suffix"
}
variable uname { default = "" }
variable upassword { default = "" }
variable location { default = "eastus2" }
variable region { default = "East US 2" }

variable "adminSourceRange" {  default = "*" }


# NETWORK
variable cidr { default = "10.90.0.0/16" }
variable "subnets" {
  type = map
  default = {
    "subnet1" = "10.90.1.0/24"
    "subnet2" = "10.90.2.0/24"
  }
}
variable bigiqPrivateMgmtIp { default = "10.90.1.4" }
variable bigiqPrivateDiscoveryIp { default = "10.90.2.4" }

# BIGIQ Image
variable instanceType { default = "Standard_D4s_v3" }
variable imageName { default = "f5-bigiq-virtual-edition-byol" }
variable product { default = "f5-big-iq" }
variable bigipVersion { default = "latest" }

# BIGIQ Setup
variable license1 { default = "" }
variable license2 { default = "" }
variable hostName { default = "bigiq" }
variable dnsServers { default = "8.8.8.8" }
variable dnsSearchDomains { default = "example.com" }
variable ntpServers { default = "0.us.pool.ntp.org" }
variable timeZone { default = "UTC" }
variable onboard_log { default = "/var/log/startup-script.log" }
#
variable "deploymentId" {
    default= "bigiq-test"
  
}
variable "allowUsageAnalytics" {
    default= false
  
}
variable intSubnetPrivateAddress { default = "10.90.3.4"}
variable "f5CloudLibsAzureTag" {
  description="release from f5-cloud-libs https://github.com/F5Networks/f5-cloud-libs-azure/releases"
  default="v2.12.0"
}
variable "f5CloudLibsTag" {
  description="release from f5-cloud-libs https://github.com/F5Networks/f5-cloud-libs/releases"
  default="v4.15.0"
}
variable "masterKey" {
  default= ""
}
variable "regPoolKeys" {
  default= "key-key-key-key"
}
variable "licensePoolKeys" {
  default= "pool-key-key-key"
}
variable "adminPassword" {
  default= ""
}
variable "sshPublicKey" {
    default = ""
}

variable "bigIqLicenseKey" {
  description= "big-iq-key-key-key"
  default = ""
}

# adminusername
# adminpassword
# masterkey
# dnslabel
# instancename
# instance_type
# bigiqversion
# bigiqlicensekey
# licensepoolkeys
# regpoolkeys
# numberofinternalIps
# vnetname
# vnetresourcegroupname
# mgmtsubnetname
# mgmipaddress
# internalsubnetname
# internalipaddreessrangestart
# avsetchoice
# ntp_server
# timezone
# customimage
# restrictedsrcaddress
# tagvalues
# allowusageanalytics
# resourcegroupname
# region
# azureloginuser
# azureloginpassword


# TAGS
variable purpose { default = "public" }
variable environment { default = "dev" } #ex. dev/staging/prod
variable owner { default = "f5owner" }
variable group { default = "f5group" }
variable costcenter { default = "f5costcenter" }
variable application { default = "f5app" }