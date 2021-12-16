@allowed([
  'AZE2'
  'AZC1'
  'AEU2'
  'ACU1'
  'AWCU'
])
param Prefix string = 'ACU1'

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

@secure()
#disable-next-line no-unused-params
param vmAdminPassword string

@secure()
#disable-next-line no-unused-params
param devOpsPat string

@secure()
#disable-next-line no-unused-params
param sshPublic string

var HubRGJ = json(Global.hubRG)

var gh = {
  hubRGPrefix: contains(HubRGJ, 'Prefix') ? HubRGJ.Prefix : Prefix
  hubRGOrgName: contains(HubRGJ, 'OrgName') ? HubRGJ.OrgName : Global.OrgName
  hubRGAppName: contains(HubRGJ, 'AppName') ? HubRGJ.AppName : Global.AppName
  hubRGRGName: contains(HubRGJ, 'name') ? HubRGJ.name : contains(HubRGJ, 'name') ? HubRGJ.name : '${Environment}${DeploymentID}'
}

var HubVNName = '${gh.hubRGPrefix}-${gh.hubRGOrgName}-${gh.hubRGAppName}-${gh.hubRGRGName}-vn'

var Deployment = '${Prefix}-${Global.OrgName}-${Global.Appname}-${Environment}${DeploymentID}'
var Domain = toUpper(split(Global.DomainName, '.')[0])

var RTInfo = contains(DeploymentInfo, 'RTInfo') ? DeploymentInfo.RTInfo : []

resource RT 'Microsoft.Network/routeTables@2018-11-01' = [for (RT, i) in RTInfo: {
  name: '${replace(HubVNName, 'vn', 'rt')}${Domain}${RT.Name}'
  location: resourceGroup().location
  properties: {
    routes: [for j in range(0, length(RT.Routes)): {
      name: '${Prefix}-${RT.Routes[j].Name}'
      properties: {
        addressPrefix: RT.Routes[j].addressPrefix
        nextHopType: RT.Routes[j].nextHopType
        nextHopIpAddress: reference(resourceId('Microsoft.Network/azureFirewalls', '${Deployment}-vn${RT.Routes[j].nextHopIpAddress}'), '2019-09-01').ipConfigurations[0].properties.privateIPAddress
      }
    }]
  }
}]
