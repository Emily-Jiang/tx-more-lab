#!/bin/sh

# Variables Section
# Location of files for Demo
USERHOME = "/home/techzone"
DEMOPATH = USERHOME + "/Student/tx-more-lab/module1"

# Install Application ModResorts
print("***Now installing Application Mod Resorts***")
AdminApp.install(
    DEMOPATH + "/modresorts/target/modresorts-2.0.0.war",
    "[ -distributeApp -useMetaDataFromBinary -appname modresorts-2_0_0_war -validateinstall warn "
    "-noallowDispatchRemoteInclude -noallowServiceRemoteInclude -novalidateSchema -contextroot /resorts "
    "-MapModulesToServers [[ modresorts-2.0.0.war modresorts-2.0.0.war,WEB-INF/web.xml "
    "WebSphere:cell=MoREDemoCell,cluster=MLSCluster],[WebSphere:cell=MoREDemoCell,node=node2,server=webserver1 ]] ]"
)
AdminConfig.save()

# Generate and Propogate Plugin
CONFIGPATH = USERHOME + "/IBM/WebSphere/AppServer/profiles/Dmgr01/config"

AdminControl.invoke(
    'WebSphere:name=PluginCfgGenerator,process=dmgr,platform=common,node=CellManager,version=9.0.5.24,type=PluginCfgGenerator,mbeanIdentifier=PluginCfgGenerator,cell=MoREDemoCell,spec=1.0',
    'generate',
    [CONFIGPATH, "MoREDemoCell", "node2", "webserver1", "false"]
)

print("***Propogating Plugin***")
AdminControl.invoke(
    'WebSphere:name=PluginCfgGenerator,process=dmgr,platform=common,node=CellManager,version=9.0.5.24,type=PluginCfgGenerator,mbeanIdentifier=PluginCfgGenerator,cell=MoREDemoCell,spec=1.0',
    'propagate',
    [CONFIGPATH, "MoREDemoCell", "node2", "webserver1"]
)
