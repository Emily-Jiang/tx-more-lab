#!/bin/sh

# Variables Section
#Location of files for Demo
demofileDir = "/home/itzuser/Demo/"
userHome = "/home/itzuser"

# Create Web Server on a Managed Node
AdminTask.createWebServer('node2', '[-name webserver1 -templateName IHS -serverConfig [-webPort 7777 -serviceName -webInstallRoot /home/itzuser/IBM/IHS -webProtocol HTTP -configurationFile -errorLogfile -accessLogfile -pluginInstallRoot /home/itzuser/IBM/IHS/plugin -webAppMapping ALL] -remoteServerConfig [-adminPort 8008 -adminUserID -adminPasswd ******** HTTP]]')
AdminConfig.save()
print "***Creating the host alias"
AdminConfig.create('HostAlias', AdminConfig.getid('/Cell:MoREDemoCell/VirtualHost:default_host/'), '[[hostname "*"] [port "7777"]]')

# Need to modify IHS Listening Port to something other than 80 due to non-root user
sed -i 's/Listen 80/Listen 7777/g' /home/itzuser/IBM/IHS/conf/httpd.conf

# Create MLS Cluster

print "***Creating cluster MLSCluster***"
AdminTask.createCluster(['-clusterConfig', ['-clusterName', 'MLSCluster', '-clusterType', 'MANAGED_LIBERTY_SERVER']])
print "***Finished createCluster***"
AdminTask.createClusterMember(['-clusterName', 'MLSCluster', '-memberConfig', ['-memberNode', 'node1', '-memberName', 'libertyServer']])
print "***Finished createClusterMember for node1***"
AdminTask.createClusterMember(['-clusterName', 'MLSCluster', '-memberConfig', ['-memberNode', 'node2', '-memberName', 'libertyServer']])
print "***Finished createClusterMember for node2***"
print "***Saving***"
print "***Syncing Node***"
AdminNodeManagement.syncActiveNodes()
print "***Successfully sync'd the nodes***"

# Install Application ModResorts
print "***Now installing Application Mod Resorts***"
AdminApp.install('/home/itzuser/Demo/modresorts-2.0.0.war', '[ -distributeApp -useMetaDataFromBinary -appname modresorts-2_0_0_war -validateinstall warn -noallowDispatchRemoteInclude -noallowServiceRemoteInclude -novalidateSchema -contextroot /resorts -MapModulesToServers [[ modresorts-2.0.0.war modresorts-2.0.0.war,WEB-INF/web.xml WebSphere:cell=MoREDemoCell,cluster=MLSCluster+WebSphere:cell=MoREDemoCell,node=node2,server=webserver1 ]]]' )
AdminConfig.save()

# Install Application PetClinic
print "***Now installing Application PetClinic***"
AdminApp.install('/home/itzuser/Demo/spring-petclinic-ear-3.4.0.ear', '[ -distributeApp -useMetaDataFromBinary -appname spring-petclinic-ear -validateinstall warn -noallowDispatchRemoteInclude -noallowServiceRemoteInclude -novalidateSchema -MapModulesToServers [[ spring-petclinic-3.4.0-SNAPSHOT.war spring-petclinic-3.4.0-SNAPSHOT.war,WEB-INF/web.xml WebSphere:cell=MoREDemoCell,cluster=MLSCluster+WebSphere:cell=MoREDemoCell,node=node2,server=webserver1 ]] -MapWebModToVH [[ spring-petclinic-3.4.0-SNAPSHOT.war spring-petclinic-3.4.0-SNAPSHOT.war,WEB-INF/web.xml default_host ]]]' )
AdminConfig.save()

# Generate and Propogate Plugin
print "***Generating Plugin***"
AdminControl.invoke('WebSphere:name=PluginCfgGenerator,process=dmgr,platform=common,node=CellManager,version=9.0.5.24,type=PluginCfgGenerator,mbeanIdentifier=PluginCfgGenerator,cell=MoREDemoCell,spec=1.0', 'generate', '[/home/itzuser/IBM/WebSphere/AppServer/profiles/Dmgr01/config MoREDemoCell node2 webserver1 false]')
print "***Propogating Plugin***"
AdminControl.invoke('WebSphere:name=PluginCfgGenerator,process=dmgr,platform=common,node=CellManager,version=9.0.5.24,type=PluginCfgGenerator,mbeanIdentifier=PluginCfgGenerator,cell=MoREDemoCell,spec=1.0', 'propagate', '[/home/itzuser/IBM/WebSphere/AppServer/profiles/Dmgr01/config MoREDemoCell node2 webserver1]')

# Start the MLS Cluster
print "***Now starting the cluster MLSCluster***"
AdminControl.invoke('WebSphere:name=MLSCluster,process=dmgr,platform=common,node=dmgr,version=9.0.5.24,type=Cluster,mbeanIdentifier=MLSCluster,cell=MoREDemoCell,spec=1.0', 'start')
print "!!!Successfully started the cluster!!!"

# Start Web Server
print "****Starting Web Server***"
AdminTask.startMiddlewareServer('[-serverName webserver1 -nodeName node2 ]')
print "You can Now point a browser to the running IHS server with context root of /resorts"

