# terraform-azure-bigiq

## terraform module for deployment of BIG-IQ in Azure




## Variables
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.25 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| adminName | admin account name | `any` | n/a | yes |
| adminPassword | admin account password | `any` | n/a | yes |
| adminSourceRange | n/a | `string` | `"*"` | no |
| allowUsageAnalytics | n/a | `bool` | `false` | no |
| application | n/a | `string` | `"f5app"` | no |
| bigIqLicenseKey | big-iq-key-key-key | `string` | `""` | no |
| bigiqPrivateDiscoveryIp | n/a | `string` | `"10.90.2.4"` | no |
| bigiqPrivateDiscoveryIpCidr | n/a | `string` | `"24"` | no |
| bigiqPrivateMgmtIp | n/a | `string` | `"10.90.1.4"` | no |
| bigiqVersion | n/a | `string` | `"latest"` | no |
| buildSuffix | resource suffix | `any` | n/a | yes |
| cidr | n/a | `string` | `"10.90.0.0/16"` | no |
| costcenter | n/a | `string` | `"f5costcenter"` | no |
| deploymentId | n/a | `string` | `"bigiq-test"` | no |
| diskType | n/a | `string` | `"Premium_LRS"` | no |
| dnsSearchDomains | n/a | `string` | `"example.com"` | no |
| dnsServers | n/a | `string` | `"8.8.8.8"` | no |
| environment | n/a | `string` | `"dev"` | no |
| f5CloudLibsAzureTag | release from f5-cloud-libs https://github.com/F5Networks/f5-cloud-libs-azure/releases | `string` | `"v2.12.0"` | no |
| f5CloudLibsTag | release from f5-cloud-libs https://github.com/F5Networks/f5-cloud-libs/releases | `string` | `"v4.15.0"` | no |
| group | n/a | `string` | `"f5group"` | no |
| hostName | n/a | `string` | `"bigiq"` | no |
| imageName | n/a | `string` | `"f5-bigiq-virtual-edition-byol"` | no |
| instanceType | BIGIQ Image | `string` | `"Standard_D4s_v3"` | no |
| license1 | BIGIQ Setup | `string` | `""` | no |
| license2 | n/a | `string` | `""` | no |
| licensePoolKeys | n/a | `string` | `"pool-key-key-key"` | no |
| location | n/a | `string` | `"eastus2"` | no |
| masterKey | bigiq master key | `any` | n/a | yes |
| networkSecurityGroup | main network security group | `any` | n/a | yes |
| ntpServers | n/a | `string` | `"0.us.pool.ntp.org"` | no |
| onboardLog | n/a | `string` | `"/var/log/startup-script.log"` | no |
| owner | n/a | `string` | `"f5owner"` | no |
| prefix | resource prefix | `string` | `"bigiq-"` | no |
| product | n/a | `string` | `"f5-big-iq"` | no |
| purpose | TAGS | `string` | `"public"` | no |
| regPoolKeys | n/a | `string` | `"key-key-key-key"` | no |
| region | n/a | `string` | `"East US 2"` | no |
| resourceGroup | resource group where the instance will be created | `any` | n/a | yes |
| sshPublicKey | ssh public key for instance access | `any` | n/a | yes |
| subnetDiscovery | discovery subnet | `any` | n/a | yes |
| subnetMgmt | management subnet | `any` | n/a | yes |
| timeZone | n/a | `string` | `"UTC"` | no |

## Outputs

| Name | Description |
|------|-------------|
| bigiq\_discovery\_private\_ip | n/a |
| bigiq\_mgmt\_private\_ip | n/a |
| bigiq\_mgmt\_public\_ip | n/a |

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

## Development
Outline any requirements to setup a development environment if someone would like to contribute.  You may also link to another file for this information.

  ```bash
  # test pre commit manually
  pre-commit run -a -v
  ```
## Support
For support, please open a GitHub issue.  Note, the code in this repository is community supported and is not supported by F5 Networks.  For a complete list of supported projects please reference [SUPPORT.md](support.md).

## Community Code of Conduct
Please refer to the [F5 DevCentral Community Code of Conduct](code_of_conduct.md).


## License
[Apache License 2.0](LICENSE)

## Copyright
Copyright 2014-2020 F5 Networks Inc.


### F5 Networks Contributor License Agreement

Before you start contributing to any project sponsored by F5 Networks, Inc. (F5) on GitHub, you will need to sign a Contributor License Agreement (CLA).

If you are signing as an individual, we recommend that you talk to your employer (if applicable) before signing the CLA since some employment agreements may have restrictions on your contributions to other projects.
Otherwise by submitting a CLA you represent that you are legally entitled to grant the licenses recited therein.

If your employer has rights to intellectual property that you create, such as your contributions, you represent that you have received permission to make contributions on behalf of that employer, that your employer has waived such rights for your contributions, or that your employer has executed a separate CLA with F5.

If you are signing on behalf of a company, you represent that you are legally entitled to grant the license recited therein.
You represent further that each employee of the entity that submits contributions is authorized to submit such contributions on behalf of the entity pursuant to the CLA.
