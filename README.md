
## Azure Deployment Framework [[ADF Docs]](https://brwilkinson.github.io/AzureDeploymentFramework/). 
#### This project is currently in Preview. [[ADF Source]](https://github.com/brwilkinson/AzureDeploymentFramework)
---
### - Declarative Infrastructure

- [Documentation - What is ADF, Observations on ARM (Bicep) Templates Etc.](./docs/ARM.md)
- [Documentation - Ready to Deploy? Getting Started Steps](./docs/Getting_Started.md)

    - [Status - Deployment Workflows GitHub](./docs/Deployment_Pipelines_GitHub.md)
    - [Status - Deployment Pipelines Azure DevOps](./docs/Deployment_Pipelines_DevOps.md)

---

Is this Framework worth considering?

    If I walk into your organization and look at your App Catalog or CMDB for your core business Applications.
    
    - How many applications do you have? (10 or 100 or 1000?)
    
    Which of those applications are really Core Business applications/services?
    
    - which make you the most money?
    - which provide the most value to your customers?
    - which are fundamentally important for running your business?
    
    Once you identity those applications/services, you need to ensure they are running in the most: 
        - efficient
        - secure
        - reliable
      manner possible, your business and competitive advantage in the marketplace depends on it.

    - how do you enhance the lifecycle of those applications and the infrastructure in a Cloud First world?
        - How do you iterate in the Sofware development lifecycle with velocity, while maintaining quality?

Microsoft recommends that you follow the:
- <a href="https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/" target="_blank">Cloud Adoption Framework</a>
- <a href="https://docs.microsoft.com/en-us/azure/architecture/framework" target="_blank">Microsoft Azure Well-Architected Framework</a>

Once you are familiar with those, how do you actually implement, by taking 1 or more of those Core App Platforms and move them to the Cloud using a Fully Declarative Model? 
    
    How do you actually implement those design patterns that are in the architectural documentation?
    How do you actually start designing and deploying your application code?
    How do you prototype out design models allowing faster testing and validation, while staying within budget?
    How do you define, deploy and release to as many environments that your application needs for: 
        - Dev, Test, QA, UAT, PROD, DR Etc. across regions.
    How do you Train your staff on Cloud principles and keep up with the rapid pace of Cloud capabilites?
    How do you Document what your environments look like and at the same time manage rapid Change?

### If that is something that is of interest to you, then this project can help.

#### Disclaimers: 
- This project should be implemented by Developers OR DevOps/SRE, this is a Declarative and Code first project.
- This project is for Deploying into Azure and Supports Hybrid scenarios, however does not work in other Clouds.
- This project does not replace other organizational level capabilities: e.g. Azure Enterprise Scale Landing Zones.
- This project allows 1 or more applications/platforms to be deployed into Azure using Infrastructure As Code (IaC).
    - Azure Resource Manager (ARM/Bicep) Templates
    - Desired State Configuration (DSC) Documents
- I would estimate for new projects, this process will take a minimum of 3, however most likely 6 to 12 months.
- Since this supports multi-tenant/multi-application, once you complete the first App migration, you can likley do your second App half the time.
- Subsequent application migrations will likley continue to take between 1 and 3 months.
- If you cut corners on the overall design of this project on naming standards and IP Address allocations Etc, you will fail in using this Framework.
- This project is a 'Framwework', it doesn't know anything about your application and you need to build and write the code to successfully deploy your application and deployment Pipelines.
- This project supports 'Lift and Shift' applications/platforms, however you get the most value you should consider re-architecting for the Cloud.
    - OR consider Lift and Shift (with modernization) as phase 1, for the first 12 months, then re-architect and migrate to PaaS in phase 2, the following 3 to 6 months.
        - Example of modernization could mean moving to the latest OS versions, or latest dependency software version, while still running IaaS Etc.
- If you are Core IT, then this Framework may not be for you. . . it's mainly based around Platform/Application deployment.
- If you don't have control over your own subscription/s, with an Owner account, then this Framework is not for you.
- If you don't have 3 to 12 months to dedicate to deploying out a single Application Platform that is core to your business, then this Framework is not for you.
- You will need a /20 IP Address range for each ADF App Tenant, that will give you 16 * 256 size address spaces or 8 * 512.
    - Even if you are running all PaaS, it would be recommended to secure your services via Private Link/Network Integration.
    - Solutions like AKS could even consume a larger range of IP's, this is something to plan upfront.
- You will want to Deploy via PowerShell V7 or later, this has the best support for JSON (and json with comments).

#### Perhaps you just need a Lab environment:
- If you are looking to build out Lab environments or use this for Demo's Etc, then the ADF will work very nicely.
    - Most of the work is deploying specific App Components, so if you are just wanted lab environments, you can get up and running with ADF very fast, **hopefully within 1 week**. The DSC components in this project allow for Domain Controller or SQL Server clusters to be deployed relatively easily, so if you are still leveraging IaaS services, this could be very useful.

### Any Feedback on this project is welcome, please feel free to reach out or ask questions, open a 'Discussions' or 'Issues'.
#### Once I have more scenarios setup and documented for this Template Project I will remove the 'Preview' Note.

<br/>

![How](./docs/ADF/Slide5.SVG)

[Documentation - What is ADF?](./docs/ADF.md)





