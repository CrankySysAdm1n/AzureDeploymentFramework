param Prefix string

@allowed([
  'I'
  'D'
  'T'
  'U'
  'P'
  'S'
  'G'
  'A'
])
param Environment string = 'D'

@allowed([
  '0'
  '1'
  '2'
  '3'
  '4'
  '5'
  '6'
  '7'
  '8'
  '9'
])
param DeploymentID string = '1'
#disable-next-line no-unused-params
param Stage object
#disable-next-line no-unused-params
param Extensions object
param Global object
param DeploymentInfo object

var Deployment = '${Prefix}-${Global.OrgName}-${Global.Appname}-${Environment}${DeploymentID}'
var DeploymentURI = toLower('${Prefix}${Global.OrgName}${Global.Appname}${Environment}${DeploymentID}')

resource OMS 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: '${DeploymentURI}LogAnalytics'
}

var HubRGJ = json(Global.hubRG)

var gh = {
  hubRGPrefix: contains(HubRGJ, 'Prefix') ? HubRGJ.Prefix : Prefix
  hubRGOrgName: contains(HubRGJ, 'OrgName') ? HubRGJ.OrgName : Global.OrgName
  hubRGAppName: contains(HubRGJ, 'AppName') ? HubRGJ.AppName : Global.AppName
  hubRGRGName: contains(HubRGJ, 'name') ? HubRGJ.name : contains(HubRGJ, 'name') ? HubRGJ.name : '${Environment}${DeploymentID}'
}

var HubRGName = '${gh.hubRGPrefix}-${gh.hubRGOrgName}-${gh.hubRGAppName}-RG-${gh.hubRGRGName}'

var KeyVaultInfo = contains(DeploymentInfo, 'KVInfo') ? DeploymentInfo.KVInfo : []

var KVInfo = [for (kv, index) in KeyVaultInfo: {
  match: ((Global.CN == '.') || contains(Global.CN, kv.name))
}]

module KeyVaults 'KV-KeyVault.bicep' = [for (kv, index) in KeyVaultInfo: if (KVInfo[index].match) {
  name: 'dp${Deployment}-KV-${kv.name}'
  params: {
    Deployment: Deployment
    DeploymentURI: DeploymentURI
    KVInfo: kv
    Global: Global
  }
}]

module vnetPrivateLink 'x.vNetPrivateLink.bicep' = [for (kv, index) in KeyVaultInfo: if (KVInfo[index].match && contains(kv, 'privatelinkinfo')) {
  name: 'dp${Deployment}-KV-privatelinkloop${kv.name}'
  params: {
    Deployment: Deployment
    PrivateLinkInfo: kv.privateLinkInfo
    providerType: 'Microsoft.KeyVault/vaults'
    resourceName: '${Deployment}-kv${kv.name}'
  }
  dependsOn: [
    KeyVaults[index]
  ]
}]

module KVPrivateLinkDNS 'x.vNetprivateLinkDNS.bicep' = [for (kv, index) in KeyVaultInfo: if (KVInfo[index].match && contains(kv, 'privatelinkinfo')) {
  name: 'dp${Deployment}-KV-registerPrivateDNS${kv.name}'
  scope: resourceGroup(HubRGName)
  params: {
    PrivateLinkInfo: kv.privateLinkInfo
    providerURL: '.azure.net/'
    resourceName: '${Deployment}-kv${((length(KeyVaultInfo) == 0) ? 'na' : kv.name)}'
    Nics: contains(kv, 'privatelinkinfo') && length(KeyVaultInfo) != 0 ? array(vnetPrivateLink[index].outputs.NICID) : array('na')
  }
}]
