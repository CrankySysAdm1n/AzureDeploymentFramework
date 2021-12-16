@allowed([
  'AZE2'
  'AZC1'
  'AEU2'
  'ACU1'
  'AWCU'
])
#disable-next-line no-unused-params
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
#disable-next-line no-unused-params
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
#disable-next-line no-unused-params
param DeploymentID string = '1'
#disable-next-line no-unused-params
param Stage object
#disable-next-line no-unused-params
param Extensions object
param Global object
param DeploymentInfo object



var DNSPublicZoneInfo = contains(DeploymentInfo, 'DNSPublicZoneInfo') ? DeploymentInfo.DNSPublicZoneInfo : []

var ZoneInfo = [for (zone, index) in DNSPublicZoneInfo: {
  match: ((Global.CN == '.') || contains(Global.CN, zone))
}]

resource DNSPublicZone 'Microsoft.Network/dnsZones@2018-05-01' = [for (zone, index) in DNSPublicZoneInfo: if (ZoneInfo[index].match) {
  name: ((length(DNSPublicZoneInfo) != 0) ? zone : 'na')
  location: 'global'
  properties: {
    zoneType: 'Public'
  }
}]
