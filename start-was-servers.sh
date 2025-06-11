#!/bin/bash

echo "Starting IHS..."
cd /home/techzone/IBM/HTTPServer/bin
./apachectl start

cd /home/techzone/IBM/WebSphere/AppServer/bin

echo "Starting Deployment Manager..."
./startManager.sh -username techzone -password IBMDem0s!

echo "Starting node agents..."
# Start node agents
./startNode.sh -profileName AppSrv01 -username techzone -password IBMDem0s!
./startNode.sh -profileName AppSrv02 -username techzone -password IBMDem0s!

echo "All servers have been started!"
