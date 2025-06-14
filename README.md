# Summary
In this interactive, hands-on lab, you'll explore the cutting-edge capabilities of WebSphere Application Server and MoRE (Modernization Runtime Extensions)—tools designed to supercharge your modernization journey. One of the standout features you'll experience is the powerful new ability to create and manage static clusters of Managed Liberty Application Servers, bringing scalability and control to a whole new level.

Each interactive module will guide you through deploying JavaEE and Jakarta applications, all seamlessly managed through the intuitive WebSphere Application Server Administrative Console. Whether you're modernizing legacy systems or building cloud-native apps, this lab is your launchpad into the next generation of enterprise application management.

```
cd /home/techzone/Student
git clone https://github.com/Emily-Jiang/tx-more-lab.git
cd tx-more-lab
```

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

# Start IHS Web Server After Creating Managed Liberty Server Cluster Using the Administrative Console
1. Login to the Administrative Console by pointing your browser to http://[hostname]:9060/admin
2. Click on Server Types and Web servers
3. Select the "webserver1" checkbox and then click on "Start"
4. Refresh the page to see the "Status" turn to a green arrow
