using '../../bicep/00-ALL-MG.bicep'

param Global = {}

param Prefix = 'ACU1'

param Environment = 'M'

param DeploymentID = '0'

param Stage = {
  RoleDefinition: 0
  Security: 0
  RBAC: 0
  roleEligibility: 0
  SP: 0
  MG: 1
}

param Extensions = {}

param DeploymentInfo = {
  rolesInfo: [
    {
      Name: 'BenWilkinson'
      RBAC: [
        {
          Name: 'Owner'
        }
      ]
    }
  ]
  RoleDefinitionsInfo: [
    {
      //  Use "Desktop Virtualization Virtual Machine Contributor" role instead of defining the custom role below
      RoleName: 'Key_Vault_Reader'
      description: 'Lets you run deployments from the KeyVault'
      notActions: []
      actions: [
        'MICROSOFT.KEYVAULT/VAULTS/DEPLOY/ACTION'
      ]
    }
  ]
  mgInfo: [
    {
      DisplayName: 'Tenant Root Group'
      Name: 'e1f9b910-3fbd-4cd8-be0f-4ed88bac571a'
      defaultManagementGroup: 'Platform'
    }
    {
      DisplayName: 'Global'
      Parent: 'e1f9b910-3fbd-4cd8-be0f-4ed88bac571a'
    }
    {
      DisplayName: 'AGI'
      Parent: 'Global'
    }
    {
      DisplayName: 'Platform'
      Parent: 'AGI'
      subscriptions: [
        '25f44cf9-ac07-4fcb-a1ad-ac4caf214f1b'
      ]
    }
  ]
}
