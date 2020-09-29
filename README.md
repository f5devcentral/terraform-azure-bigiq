# terraform-azure-bigiq

## terraform module for deployment of BIG-IQ in Azure




## Variables
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## todo:
### secrets azure key store
https://github.com/mjmenger/terraform-azure-bigip-setup/blob/master/secrets.tf

### bigiq ver > 7.1
### ansible to configure
https://github.com/f5devcentral/f5-big-iq-onboarding
### update onboard to use python from quickstart
https://github.com/f5devcentral/f5-big-iq-trial-quick-start/tree/7.1.0/scripts

### variable instance types:

Standard_DS2_v2
Standard_D4s_v3

### variable disk types:

managed_disk_type = "Standard_LRS"
managed_disk_type = "Premium_LRS"    
