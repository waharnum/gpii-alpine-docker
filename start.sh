#!/bin/bash

# clean up
kubectl delete deployment gpii-deployment
kubectl delete service gpii-service-couchdb
kubectl delete service gpii-service-preferences-server
kubectl delete service gpii-service-flow-manager
kubectl delete job dataloader

# use minikube's docker instance
eval $(minikube docker-env)

# build the containers
docker build -t gpiilab/nodejs node/.
docker build -t gpiilab/universal universal/.
docker build -t gpiilab/preferences-server prefserver/.
docker build -t gpiilab/flow-manager flowmanager/.
docker build -t gpiilab/dataloader dataloader/.

# create the deployment and service

kubectl create -f gpii-deployment.yaml
kubectl create -f gpii-service-preferences-server.json
kubectl create -f gpii-service-couchdb.json
kubectl create -f gpii-service-flow-manager.json

couchDBAddress=$(minikube service gpii-service-couchdb --url)
preferencesServerAddress=$(minikube service gpii-service-preferences-server --url)
flowManagerAddress=$(minikube service gpii-service-flow-manager --url)

echo "Launching dataloader job"
kubectl create -f gpii-job-dataloader.yaml

# Show the job log
sleep 5
dataloaderPod=$(kubectl get pods --selector=job-name=dataloader --output=jsonpath={.items..metadata.name})
kubectl logs $dataloaderPod -f

echo "Giving dataloader job time to complete... (crude, I know)"
sleep 30

echo "Getting (via curl) carla test user's preferences from Preference Server"
curl $(minikube service gpii-service-preferences-server --url)/preferences/carla
echo

echo "Getting (via curl) carla test user's org.gnome.desktop.a11y.magnifier preference from Flow Manager"
curl -g $(minikube service gpii-service-flow-manager --url)/carla/settings/%7B%22OS%22:%7B%22id%22:%22linux%22%7D,%22solutions%22:[%7B%22id%22:%22org.gnome.desktop.a11y.magnifier%22%7D]%7D
echo

echo "CouchDB available at: $couchDBAddress"

echo "Preferences Server available at:"
echo $preferencesServerAddress

echo "Flow Manager available at:"
echo $flowManagerAddress
