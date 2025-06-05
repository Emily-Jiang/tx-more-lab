#!/bin/sh

# Variables Section
#Location of files for Demo
demofileDir = "/home/itzuser/Demo/"
userHome = "/home/itzuser"


# Create MLS Cluster

print "***Creating cluster MLSCluster***"
AdminTask.createCluster(['-clusterConfig', ['-clusterName', 'MLSCluster', '-clusterType', 'MANAGED_LIBERTY_SERVER']])
print "***Finished createCluster***"
AdminTask.createClusterMember(['-clusterName', 'MLSCluster', '-memberConfig', ['-memberNode', 'node1', '-memberName', 'libertyServer_node1']])
print "***Finished createClusterMember for node1***"
AdminTask.createClusterMember(['-clusterName', 'MLSCluster', '-memberConfig', ['-memberNode', 'node2', '-memberName', 'libertyServer_node2']])
print "***Finished createClusterMember for node2***"
print "***Saving***"
print "***Syncing Node***"
AdminNodeManagement.syncActiveNodes()
print "***Successfully sync'd the nodes***"


# Start the MLS Cluster
print "***Now starting the cluster MLSCluster***"
AdminControl.invoke('WebSphere:name=MLSCluster,process=dmgr,platform=common,node=dmgr,version=9.0.5.24,type=Cluster,mbeanIdentifier=MLSCluster,cell=MoREDemoCell,spec=1.0', 'start')
print "!!!Successfully started the cluster!!!"


