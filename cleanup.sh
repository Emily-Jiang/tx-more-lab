#!/bin/bash

cd /home/techzone/IBM/WebSphere/AppServer/bin

echo "Stopping all servers..."
# Stop all named servers
./stopServer.sh libertyServer -profileName AppSrv01 -username techzone -password IBMDem0s!
./stopServer.sh libertyServer -profileName AppSrv02 -username techzone -password IBMDem0s!
./stopServer.sh webserver1 -profileName AppSrv02 -username techzone -password IBMDem0s!
./stopManager.sh -username techzone -password IBMDem0s!
# Stop all node agents
./stopNode.sh -profileName AppSrv01 -username techzone -password IBMDem0s!
./stopNode.sh -profileName AppSrv02 -username techzone -password IBMDem0s!

echo "Removing all profiles..."
./manageprofiles.sh -deleteAll
rm -rf ../profiles/AppSrv01
rm -rf ../profiles/AppSrv02
rm -rf ../profiles/Dmgr01

echo "Stopping IHS..."
cd /home/techzone/IBM/HTTPServer/bin
./adminctl stop

echo "Cleanup complete."
