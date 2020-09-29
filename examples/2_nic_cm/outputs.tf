# outputs from example centralized manager

## OUTPUTS ###
output "bigiq_mgmt_public_ip" {
  value = module.bigiq.bigiq_mgmt_public_ip
}
output "bigiq_mgmt_private_ip" {
  value = module.bigiq.bigiq_mgmt_private_ip
}
output "bigiq_discovery_private_ip" {
  value = module.bigiq.bigiq_discovery_private_ip
}