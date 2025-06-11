#!/bin/bash

/home/techzone/IBM/WebSphere/AppServer/profiles/Dmgr01/bin/wsadmin.sh \
  -lang jython -user techzone -password IBMDem0s! \
  -f /home/techzone/Student/tx-more-lab/scripts/deleteMLSCluster.py

echo "Stopping IHS..."
cd /home/techzone/IBM/HTTPServer/bin
./apachectl stop

cd /home/techzone/IBM/WebSphere/AppServer/bin

echo "Stopping node agents..."
./stopNode.sh -profileName AppSrv01 -username techzone -password IBMDem0s!
./stopNode.sh -profileName AppSrv02 -username techzone -password IBMDem0s!

echo "Stopping Deployment Manager..."
./stopManager.sh -username techzone -password IBMDem0s!

echo "All servers have been stopped!"
