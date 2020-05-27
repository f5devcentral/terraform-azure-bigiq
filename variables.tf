# Azure Environment
variable resourceGroup {
    description = "resource group where the instance will be created"
}
variable prefix { 
    description = "resource prefix"
    default = "bigiq-" 
}
variable "buildSuffix" {
  description = "resource suffix"
}
variable location { default = "eastus2" }
variable region { default = "East US 2" }

# NETWORK
variable networkSecurityGroup {
    description = "main network security group"
}
variable cidr { default = "10.90.0.0/16" }
variable subnetMgmt {
    description = "management subnet"
}
variable subnetDiscovery {
    description = "discovery subnet"
}
variable bigiqPrivateMgmtIp { default = "10.90.1.4" }
variable bigiqPrivateDiscoveryIp { default = "10.90.2.4" }
variable bigiqPrivateDiscoveryIpCidr { default = "24"}
# admin
variable adminName {
    description = "admin account name"
}
variable adminPassword {
  description = "admin account password"
}
variable sshPublicKey {
    description = "ssh public key for instance access"
}
variable adminSourceRange {  default = "*" }
# BIGIQ Image
variable instanceType { default = "Standard_D4s_v3" }
variable imageName { default = "f5-bigiq-virtual-edition-byol" }
variable product { default = "f5-big-iq" }
variable bigipVersion { default = "latest" }
variable diskType { default = "Premium_LRS" }

# BIGIQ Setup
variable license1 { default = "" }
variable license2 { default = "" }
variable hostName { default = "bigiq" }
variable dnsServers { default = "8.8.8.8" }
variable dnsSearchDomains { default = "example.com" }
variable ntpServers { default = "0.us.pool.ntp.org" }
variable timeZone { default = "UTC" }
variable onboardLog { default = "/var/log/startup-script.log" }
#
variable deploymentId {
    default= "bigiq-test"
  
}
variable allowUsageAnalytics {
    default= false
  
}
variable f5CloudLibsAzureTag {
  description="release from f5-cloud-libs https://github.com/F5Networks/f5-cloud-libs-azure/releases"
  default="v2.12.0"
}
variable f5CloudLibsTag {
  description="release from f5-cloud-libs https://github.com/F5Networks/f5-cloud-libs/releases"
  default="v4.15.0"
}
variable masterKey {
  description = "bigiq master key"
}
variable regPoolKeys {
  default= "key-key-key-key"
}
variable licensePoolKeys {
  default= "pool-key-key-key"
}
variable bigIqLicenseKey {
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