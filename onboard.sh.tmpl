#!/bin/bash
# require jq
#
# logging
LOG_FILE=${onboard_log}
if [ ! -e $LOG_FILE ]
then
     touch $LOG_FILE
     exec &>>$LOG_FILE
else
    #if file exists, exit as only want to run once
    exit
fi

exec 1>$LOG_FILE 2>&1
#
startTime=$(date +%s)
echo "timestamp start: $(date)"

# usage: make sure there is internet connection to GitHub
function check_internet_connection {
    echo "--- Checking Github status ---"
    checks=0
    github_response="bad"
    while [ $checks -lt 120 ] ; do
        github_response=`curl -s https://www.githubstatus.com/api/v2/status.json | jq .status.description --raw-output`
        if [ "$github_response" == "All Systems Operational" ]; then
            log "GitHub is ready"
            break
        fi
        log "GitHub not ready: $checks"
        let checks=checks+1
        sleep 5
    done
    if [ "$github_response" == "bad" ]; then
        log "No GitHub internet connection."
        exit
    fi
}

# mcpd status
echo  "wait for mcpd"
function waitMcpd () {
checks=0
while [[ "$checks" -lt 120 ]]; do 
    echo "checking mcpd"
    tmsh -a show sys mcp-state field-fmt | grep -q running
   if [ $? == 0 ]; then
       echo "mcpd ready"
       break
   fi
   echo "mcpd not ready yet"
   let checks=checks+1
   sleep 10
done
}
waitMcpd
# create admin account and password
echo "create admin account"
admin_username='${uname}'
admin_password='${upassword}'

tmsh create auth user $admin_username password $admin_password shell bash partition-access add { all-partitions { role admin } };
tmsh modify auth user $admin_username shell bash partition-access add { all-partitions { role admin } };
tmsh list auth user $admin_username
echo "root:"$admin_password"" | chpasswd
echo "admin:"$admin_password"" | chpasswd
tmsh save sys config

CREDS="$admin_username:$admin_password"

# copy ssh key
mkdir -p /home/$admin_username/.ssh/
cp /home/admin/.ssh/authorized_keys /home/$admin_username/.ssh/authorized_keys
echo " admin account changed"

#
# vars
#
uname="${uname}"
upassword="${upassword}"
onboard_log="${onboard_log}"
bigIqLicenseKey1="${bigIqLicenseKey1}"
ntpServers="${ntpServer}"
ntpTimeZone="${timeZone}"
licensePoolKeys="${licensePoolKeys}"
regPoolKeys="${regPoolKeys}"
adminPassword="${adminPassword}"
masterKey='${masterKey}'
f5CloudLibsTag="${f5CloudLibsTag}"
f5CloudLibsAzureTag="${f5CloudLibsAzureTag}"
intSubnetPrivateAddress="${intSubnetPrivateAddress}"
allowUsageAnalytics="${allowUsageAnalytics}"
location="${location}"
subscriptionID="${subscriptionID}"
deploymentId="${deploymentId}"
dnsSearchDomains="${dnsSearchDomains}"
dnsServers="${dnsServers}"
#
# end vars
#
# constants
CURL="/usr/bin/curl"
cloud="azure"
mgmt_port=`tmsh list sys httpd ssl-port | grep ssl-port | sed 's/ssl-port //;s/ //g'`
systemInfoUrl="/info/system"
authUrl="/mgmt/shared/authn/login"
launchStatusUrl="/mgmt/setup/launch/status"
licenseUrl7="/mgmt/setup/license/activate"
licenseUrl6="/mgmt/tm/shared/licensing/activation"
eulaUrl7="/mgmt/setup/license/accept-eula"
eulaUrl6="/mgmt/setup/license/accept-eula"
licenseRegistrationUrl6="/mgmt/tm/shared/licensing/registration"
licenseRegistrationUrl7="/mgmt/setup/license"
personalityUrl="/mgmt/setup/personality"
base_url="https://raw.githubusercontent.com/F5Networks"
base_dir="/config/cloud"
base_log_dir="/var/log/cloud/$${cloud}"
base_dependency_dir="$${base_dir}/$${cloud}/node_modules/@f5devcentral"
localHost="https://localhost:"
hostNameUrl6="/mgmt/shared/system/easy-setup"
hostNameUrl7="/mgmt/setup/address"
hostName1="${hostName1}"
hostName2="${hostName2}"
hostName="${hostName1}"
masterKeyUrl6="/mgmt/cm/shared/secure-storage/masterkey"
masterKeyUrl7="/mgmt/setup/masterkey"
vlanUrl6="/mgmt/tm/net/vlan"
vlanUrl7="/mgmt/setup/address/vlan"
selfipUrl7="/mgmt/setup/address/self-ip"
selfipUrl6="/mgmt/tm/net/self"
dnsUrl6="/mgmt/tm/sys/dns"
dnsUrl7="/mgmt/setup/dns"
ntpUrl6="/mgmt/tm/sys/ntp"
ntpUrl7="/mgmt/setup/ntp"
systemSetupUrl6="/mgmt/shared/system/setup"
systemSetupUrl7="/mgmt/setup/launch"
discoveryUrl6="/mgmt/shared/identified-devices/config/discovery"
discoveryUrl7="/mgmt/setup/address"
passwordRootUrl6="/mgmt/shared/authn/root"
passwordAdminUrl6="/mgmt/shared/authz/users"
passwordRootUrl7="/mgmt/setup/password"
passwordAdminUrl7="/mgmt/setup/password"
passwordChangedUrl6="/mgmt/shared/system/setup"
passwordChangedUrl7="/mgmt/setup/password"
#
# functions
# usage: log message
function log() {
    echo "$(date '+%Y-%m-%dT%H:%M:%SZ'): $1"
}
# usage: Download from Github until successful
#
# $1: output file name
# $2: URL
function safe_download {
    checks=0
    while [ $checks -lt 120 ] ; do
        $CURL -s --fail --retry 20 --retry-delay 5 --retry-max-time 240 -o $1 $2 && break
        let checks=checks+1
        sleep 5
    done
}
# get token with admin creds
getToken () {
    token=$(curl -sk --header "Content-Type:application/json" --data "$credsPayload" --url $localHost$mgmt_port$authUrl | jq -r .token.token)
    echo "$token"
}
# set token header for curl
setToken () {
    #--header "X-Vault-Token: $VAULT_TOKEN" 
    token=$(getToken)
    tokenHeader="X-F5-Auth-Token: $token"
    echo "$tokenHeader"
}
# wait for bigiq
function waitIq () {
  count=0
  while [ $count -le 10 ]
  do
    status=$( curl -sk --header "$(setToken)" https://localhost:$mgmt_port$systemInfoUrl | jq .)
    statusType=$(echo $status | jq -r type)
    if [ "$statusType" == "object" ]; then
      state=$( echo $status | jq -r .available)
      if [ "$state" == "true" ]; then
        echo "ready"
        break
      else
        count=$[$count+1]
        sleep 30
      fi
    else
      count=$[$count+1]
      sleep 30
    fi
    if [ $count == 10 ]; then 
      echo "failed: $state"
    fi
  done
}
# check bigiq build
checkVersion () {
    status=$(waitIq)
    if [ "$status" == "ready" ]; then
        build=$(curl -sk --header "$(setToken)" --url $localHost$mgmt_port/info/system | jq -r .build)
        if [[ "$build" =~ '7.1' ]];
        then
            echo "7"
        else
            echo "6"
        fi
    else
        echo "IQ not ready"
    fi
}
getDossier () {
 dossier=$(get_dossier -b $1)
 echo "$dossier"
}
licenseActivate () {
    curl -sk --header "Content-Type:application/json" --header "$(setToken)" --data "$1" --url $localHost$mgmt_port$licenseUrl
    #curl -sk --header "$(setToken)" --data "$licensePayload" --url $localHost$mgmt_port$licenseUrl
    #curl -sk --header "$(setToken)" --data "$eulaPayload7" --url $localHost$mgmt_port$licenseUrl
    #curl -sk --header "$(setToken)" --data "$eulaPayload6" --url $localHost$mgmt_port$licenseUrl
}
licenseRegistration () {
    if [[ "$(checkVersion)" == "7" ]]; then
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$1" --url $localHost$mgmt_port$licenseRegistrationUrl
        # after id is set the url changes back to the 6 url
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X PUT --data "$1" --url $localHost$mgmt_port$licenseRegistrationUrl6 
    else
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X PUT --data "$1" --url $localHost$mgmt_port$licenseRegistrationUrl
    fi
    
}
checkLicense () {
    #status=$(curl -sk --header "$(echo "setToken")" --url $localHost$mgmt_port$licenseUrl | jq .status )
    status=$(curl -sk --header "$(setToken)" --url $localHost$mgmt_port$licenseUrl | jq -r .status )
    case $status in 
    LICENSING_ACTIVATION_IN_PROGRESS)
        # inprogress
        echo "inprogress"
        ;;
    LICENSING_COMPLETE)
        # finished
        echo "complete"
        ;;
    LICENSING_FAILED)
        # started
        echo "failed"
        ;;
    NEED_EULA_ACCEPT)
        # running
        echo "eula"
        ;;
    *)
        # other
        debug=$(curl -sk -u $CREDS $localHost$mgmt_port$licenseUrl | jq . )
        echo "Other error: $debug"
        ;;
    esac

}

#eula
getEulaPayload () {
if [[ "$(checkVersion)" == "7" ]]; then
eulaPayload7=$(cat -<<EOF
  {
  "baseRegKey": "${ bigIqLicenseKey1 }",
  "dossier: "$(getDossier ${ bigIqLicenseKey1 })",
  "eulaText": $(curl -sk --header "$(setToken)" --url $localHost$mgmt_port$licenseUrl | jq .eulaText)
  }

EOF
)
echo "$eulaPayload7"
else 
eulaPayload6=$(cat -<<EOF
  {
  "baseRegKey": "${ bigIqLicenseKey1 }",
  "addOnKeys": [],
  "activationMethod": "AUTOMATIC",
  "eulaText": $(curl -sk --header "$(setToken)" --url $localHost$mgmt_port$licenseUrl | jq .eulaText)
  }

EOF
)
echo "$eulaPayload6"
fi
}
# license
getLicenseFilePayload () {
licenseFilePayload=$(cat -<<EOF
{
   "licenseText": $(curl -sk --header "$(setToken)" --url $localHost$mgmt_port$licenseUrl | jq .licenseText)
}
EOF
)
echo "$licenseFilePayload"
}
setHostName () {
    if [[ "$(checkVersion)" == "7" ]]; then
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$hostNamePayload" --url $localHost$mgmt_port$hostNameUrl  
    else
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X PATCH --data "$hostNamePayload" --url $localHost$mgmt_port$hostNameUrl  
    fi
}
setMasterKey () {
  curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$masterKeyPayload" --url $localHost$mgmt_port$masterKeyUrl   
}
createDiscoveryVlan () {
 curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$vlanPayload" --url $localHost$mgmt_port$vlanUrl 
}
createDiscoverySelfIp () {
 curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$selfIpPayload" --url $localHost$mgmt_port$selfIpUrl 
}
setDiscoveryAddress () {
     if [[ "$(checkVersion)" == "7" ]]; then
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$discoveryPayload" --url $localHost$mgmt_port$discoveryUrl
    else
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X PUT --data "$discoveryPayload" --url $localHost$mgmt_port$discoveryUrl
    fi
}
setDns () {
    if [[ "$(checkVersion)" == "7" ]]; then
        curl -sk  --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$dnsPayload" --url $localHost$mgmt_port$dnsUrl
    else
        curl -sk  --header "Content-Type:application/json" --header "$(setToken)" -X PATCH --data "$dnsPayload" --url $localHost$mgmt_port$dnsUrl
    fi
}
setNtp () {
    if [[ "$(checkVersion)" == "7" ]]; then
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$ntpPayload" --url $localHost$mgmt_port$ntpUrl
    else
        curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X PATCH --data "$ntpPayload" --url $localHost$mgmt_port$ntpUrl
    fi
}
submitSetup () {
    curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$systemSetupPayload" --url $localHost$mgmt_port$systemSetupUrl
}
setPasswords () {
 if [[ "$(checkVersion)" == "7" ]]; then
    curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$passwordPayload7" --url $localHost$mgmt_port$passwordRootUrl7
 else
    curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$passwordRootPayload6" --url $localHost$mgmt_port$passwordRootUrl6
    curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$passwordAdminPayload6" --url $localHost$mgmt_port$passwordAdminUrl6
    curl -sk --header "Content-Type:application/json" --header "$(setToken)" -X POST --data "$passwordChangedPayload6" --url $localHost$mgmt_port$passwordChangedUrl6
 fi
}
function RestCall () {
  count=0
  while [ $count -le 4 ]
  do
    # status=$(curl -s -k -u $CREDS $systemInfoUrl | jq .)
    status=$( curl -sk -u $CREDS https://localhost:$mgmt_port/info/system | jq .)
    case $status in 
        FINISHED)
            # finished
            echo " rpm: $filename task: $install status: $status"
            break
            ;;
        STARTED)
            # started
            echo " rpm: $filename task: $install status: $status"
            ;;
        RUNNING)
            # running
            echo " rpm: $filename task: $install status: $status"
            ;;
        FAILED)
            # failed
            error=$(restcurl -u $CREDS $rpmInstallUrl/$install | jq .errorMessage)
            echo "failed $filename task: $install error: $error"
            break
            ;;
        *)
            # other
            debug=$(restcurl -u $CREDS $rpmInstallUrl/$install | jq . )
            echo "failed $filename task: $install error: $debug"
            ;;
        esac
    sleep 2
    done
}
#
# end functions
#
# set payloads
# password
passwordPayloadRoot6=$(cat -<<EOF
{
    "oldPassword":"$admin_password",
    "newPassword":"$admin_password"
}
EOF
)
passwordPayloadadmin6=$(cat -<<EOF
{
    "oldPassword":"$admin_password",
    "password":"$admin_password",
    "password2":"$admin_password"
}
EOF
)
passwordPayload7=$(cat -<<EOF
{
    "admin":"$admin_password",
    "root":"$admin_password"
}
EOF
)
passwordChangedPayload6=$(cat -<<EOF
{
    "isRootPasswordChanged": true,
    "isAdminPasswordChanged": true
}
EOF
)
# ntp
ntpPayload=$(cat -<<EOF
{
    "servers": ["$ntpServers"],
    "timezone": "$ntpTimeZone"
}
EOF
)
# dns
dnsPayload6=$(cat -<<EOF
{
    "nameServers": ["$dnsServers"],
    "search": ["$dnsSearchDomains"]
}
EOF
)
dnsPayload7=$(cat -<<EOF
{
    "servers": ["$dnsServers"],
    "search": ["$dnsSearchDomains"]
}
EOF
)
# systemsetup
systemSetupPayload=$(cat -<<EOF
{
    "isSystemSetup": true
}
EOF
)
# discovery
vlanPayload6=$(cat -<<EOF
{
    "name": "discovery",
    "tag": 0,
    "mtu": 1500,
    "interfacesReference": {
        "items": [
            {
                "name": "1.1",
                "untagged": true
            }
        ]
    }
}
EOF
)
vlanPayload7=$(cat -<<EOF
{
    "name": "discovery",
    "interfaces": [
        {
            "name": "1.1",
            "untagged": true
        }
    ],
    "tag": 100,
    "mtu": 1600
}
EOF
)
# discovery
discoveryPayload=$(cat -<<EOF
{
    "discoveryAddress": "${discoveryAddress}"
}
EOF
)
# selfIp
selfIpPayload6=$(cat -<<EOF
{
    "name": "self_discovery",
    "address": "${discoveryAddressSelfip}",
    "vlan": "/Common/discovery",
    "description": "",
    "fullPath": "/Common/self_discovery",
    "allow-service": "default"
}
EOF
)
selfIpPayload7=$(cat -<<EOF
{
    "name": "self_discovery",
    "address": "${discoveryAddressSelfip}",
    "vlan": "/Common/discovery"
}
EOF
)
# masterkey
masterKeyPayload=$(cat -<<EOF
{
    "passphrase": "$masterKey"
}
EOF
)
# hostname
hostNamePayload=$(cat -<<EOF
{
    "hostname": "$hostName"
}
EOF
)
# creds
credsPayload=$(cat -<<EOF
{
    "username": "$admin_username",
    "password": "$admin_password"
}
EOF
)

#license
if [ "$bigIqLicenseKey1" == "" ]; then
licensePayload=$(cat -<<EOF
  {
      "licenseText": "skipLicense:true"
  }
EOF
)
else
licensePayload=$(cat -<<EOF
  {
      "baseRegKey": "${ bigIqLicenseKey1 }",
      "addOnKeys": [],
      "activationMethod": "AUTOMATIC"
  }
EOF
)
fi

#personality
personality=$(cat -<<EOF
{
  "systemPersonality": "logging_node"
}
EOF
)
#
#
#
# end payloads
# 
# begin setup
#
# wait for mcpd
echo "wait for mcpd"
waitMcpd
### Install dependencies ###
## There must be GitHub internet connection
echo "check internet"
check_internet_connection

## Download dependencies
dependencies=("$${base_url}/f5-cloud-libs/$${f5CloudLibsTag}/dist/f5-cloud-libs.tar.gz")
dependencies+=("$${base_url}/f5-cloud-libs-$${cloud}/$${f5CloudLibsAzureTag}/dist/f5-cloud-libs-$${cloud}.tar.gz")
dependencies+=("$${base_url}/f5-cloud-libs/$${f5CloudLibsTag}/dist/verifyHash")

for i in $${dependencies[@]} ; do
    log "Downloading dependency: $i"
    f=$(basename $i)
    safe_download $${base_dir}/$f $i
    # $CURL -ksf --retry 10 --retry-delay 5 --retry-max-time 240 -o $${base_dir}/$f $i
done
#
# check  bigiq status
echo "check bigiq status"
if [[ "$(waitIq)" == "ready" ]]; then
    echo "ready"
else
    echo "failed IQ status not ready"
    exit
fi
# 
# check bigiq version
#
echo "check bigiq version"
if [[ "$(checkVersion)" == "7" ]]; then
    # set urls for >= 7.1
    licenseUrl="$licenseUrl7"
    eulaUrl="$eulaUrl7"
    eulaPayload="$eulaPayload7"
    licenseRegistrationUrl="$licenseRegistrationUrl7"
    hostNameUrl="$hostNameUrl7"
    masterKeyUrl="$masterKeyUrl7"
    selfIpPayload="$selfIpPayload7"
    vlanUrl="$vlanUrl7"
    vlanPayload="$vlanPayload7"
    selfIpUrl="$selfipUrl7"
    dnsUrl="$dnsUrl7"
    dnsPayload="$dnsPayload7"
    ntpUrl="$ntpUrl7"
    discoveryUrl="$discoveryUrl7"
    systemSetupUrl="$systemSetupUrl7"
    passwordRootUrl="$passwordRootUrl7"
    passwordAdminUrl="$passwordAdminUrl7"
    passwordChangedUrl="$passwordChangedUrl7"
else
    # set urls for < 7.1
    licenseUrl="$licenseUrl6"
    eulaUrl="$eulaUrl6"
    eulaPayload="$eulaPayload6"
    licenseRegistrationUrl="$licenseRegistrationUrl6"
    hostNameUrl="$hostNameUrl6"
    masterKeyUrl="$masterKeyUrl6"
    selfIpPayload="$selfIpPayload6"
    vlanUrl="$vlanUrl6"
    vlanPayload="$vlanPayload6"
    selfIpUrl="$selfipUrl6"
    dnsUrl="$dnsUrl6"
    dnsPayload="$dnsPayload6"
    ntpUrl="$ntpUrl6"
    discoveryUrl="$discoveryUrl6"
    systemSetupUrl="$systemSetupUrl6"
    passwordRootUrl="$passwordRootUrl6"
    passwordAdminUrl="$passwordAdminUrl6"
    passwordChangedUrl="$passwordChangedUrl6"
fi
echo " version $(checkVersion)"
#
# license BiqIq
#
echo "license bigiq"
# send license payload
if [ "$bigIqLicenseKey1" == "" ]; then
    echo "bigiq-license manager"
    licenseRegistration "$licensePayload"
else
    echo "bigiq-cm"
    licenseActivate "$licensePayload"
    # check license install state
    while [[ $count -le 4 ]]
    do
        if [[ "$(checkLicense)" == "eula" ]]; then
            eula=$(curl -sk --header "$(setToken)" --url $localHost$mgmt_port$licenseUrl | jq -r .eulaText)
            licenseActivate "$(getEulaPayload)"
            echo "send eula"
        fi
        if [[ "$(checkLicense)" == "failed" ]]; then
            if [ "$bigIqLicenseKey1" == "" ]; then
                licenseRegistration "$licensePayload"
            else
                echo "check license key"
            fi
        fi
        if [[ "$(checkLicense)" == "complete" ]]; then
            licenseData=$(curl -sk --header "$(setToken)" --url $localHost$mgmt_port$licenseUrl | jq .licenseText)
            # license
            licensePayload="{\"licenseText\": $licenseData}"
            # install license
            echo "install license"
            licenseRegistration "$(getLicenseFilePayload)"
            fi
        sleep 2
        count=$[$count+1]
    done
fi
# wait for mcpd after license
waitMcpd
#
# license done
#
echo "set hostname"
setHostName
echo "set masterkey"
setMasterKey
echo "set passwords"
setPasswords
echo "create vlan"
createDiscoveryVlan
echo "set selfip"
createDiscoverySelfIp
echo "set discovery address"
setDiscoveryAddress
echo "set dns"
setDns
echo "set ntp"
setNtp
echo "launching"
submitSetup
waitMcpd
waitIq
#
# done
#
echo "done saving configuration"

tmsh save sys config
echo "timestamp end: $(date)"
exit