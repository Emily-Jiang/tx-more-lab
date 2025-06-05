#!/bin/sh

# Variables Section
#Location of files for Demo
demofileDir = "/home/itzuser/Demo/"
userHome = "/home/itzuser"


# Install Application PetClinic
print "***Now installing Application PetClinic***"
AdminApp.install('/home/itzuser/Demo/spring-petclinic-ear-3.4.0.ear', '[ -distributeApp -useMetaDataFromBinary -appname spring-petclinic-ear -validateinstall warn -noallowDispatchRemoteInclude -noallowServiceRemoteInclude -novalidateSchema -MapModulesToServers [[ spring-petclinic-3.4.0-SNAPSHOT.war spring-petclinic-3.4.0-SNAPSHOT.war,WEB-INF/web.xml WebSphere:cell=MoREDemoCell,cluster=MLSCluster+WebSphere:cell=MoREDemoCell,node=node2,server=webserver1 ]] -MapWebModToVH [[ spring-petclinic-3.4.0-SNAPSHOT.war spring-petclinic-3.4.0-SNAPSHOT.war,WEB-INF/web.xml default_host ]]]' )
AdminConfig.save()

# Generate and Propogate Plugin
print "***Generating Plugin***"
AdminControl.invoke('WebSphere:name=PluginCfgGenerator,process=dmgr,platform=common,node=CellManager,version=9.0.5.24,type=PluginCfgGenerator,mbeanIdentifier=PluginCfgGenerator,cell=MoREDemoCell,spec=1.0', 'generate', '[/home/itzuser/IBM/WebSphere/AppServer/profiles/Dmgr01/config MoREDemoCell node2 webserver1 false]')
print "***Propogating Plugin***"
AdminControl.invoke('WebSphere:name=PluginCfgGenerator,process=dmgr,platform=common,node=CellManager,version=9.0.5.24,type=PluginCfgGenerator,mbeanIdentifier=PluginCfgGenerator,cell=MoREDemoCell,spec=1.0', 'propagate', '[/home/itzuser/IBM/WebSphere/AppServer/profiles/Dmgr01/config MoREDemoCell node2 webserver1]')
print "***Successfully Propogated the Plugin***"

