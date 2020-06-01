# 2 nic central manager

## variables
### bigiq
adminSourceRange

adminAccountName

adminAccountPassword

sshPublicKey

masterKey 

### azure
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID
## Usage
To run this example run the following commands:
```bash
terraform init
terraform plan
terraform apply --auto-approve 
```

**Note:** this examples deploys resources that will cost money.  Please run the following command to destroy your environment when finished:
```bash
terraform destroy --auto-approve
```