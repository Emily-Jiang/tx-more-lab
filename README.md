# Summary
In this hands on lab, you will experience some of the new capabiltiies provided by WebSphere Application Server and MoRE (Modernization Runtime Extensions). One of the key capabilities delivered is the ability to create and manage static clusters of Managed Liberty Application Servers. Each module walks through an installation of JavaEE and Jakarta applications that can be managed in the WebSphere Application Server Administrative Console

# Create Static Managed Liberty Server Cluster Using the Administrative Cluster
1. Login to the Administrative Console by pointing your browser to http://[hostname]:9060/admin
2. Click on "Clusters" and then "WebSphere application server clusters"
3. Click on New and in the "Cluster name" field input "MLSCluster"
4. In the "Member Name" field, enter "libertyServer_node1", ensure "node1" is selected under "Select node", and in the "Select basis for first cluster member" section, select "default-managed-liberty-server" from the pull down under the "Create the member using an application server template"
5. Click "Next"
6. In the "Create additional cluster members" page, under "Member name" enter "libertyServer_node2", ensure "node2" is selected under "Select node" pull down
7. Click "Add Member". There should now be two members of the cluster, one on each node. Click "Next"
8. The cluster creation summary is now displayed. Click "Finish" to complete cluster creation
9. Click on "Save" to save the configuration
10. Click on "System administration" and then "Nodes". Select both nodes and click on "Synchronize"

# Create Static Managed Liberty Server Cluster using Admin Scripting
1. Clone this repository on the System with the command git clone
2. Copy the createMLSCluster.py script to the Deployment Manager bin directory under /opt/WAS/profiles/dmgr/bin
3. Run the command ```./wsadmin.sh -lang jython -f createMLSCluster.py -user admin -password IBMDem0S```
