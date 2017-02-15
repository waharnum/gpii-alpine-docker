# clean up
kubectl delete deployment gpii-deployment
kubectl delete service gpii-service-preferences-server
kubectl delete service gpii-service-couchdb
kubectl delete job dataloader

# use minikube's docker instance
eval $(minikube docker-env)

# build the containers
docker build -t gpiilab/nodejs node/.
docker build -t gpiilab/universal universal/.
docker build -t gpiilab/preferences-server prefserver/.
docker build -t gpiilab/dataloader dataloader/.

# create the deployment and service

kubectl create -f gpii-deployment.yaml
kubectl create -f gpii-service-preferences-server.json
kubectl create -f gpii-service-couchdb.json

echo "Preferences Server available at:"
echo $(minikube service gpii-service-preferences-server --url)

echo "CouchDB available at:"
echo $(minikube service gpii-service-couchdb --url)

echo "Launching dataloader job"
kubectl create -f gpii-job-dataloader.yaml

echo "Giving dataloader time to complete..."
sleep 30

echo "CURLIing Carla"
curl $(minikube service gpii-service-preferences-server --url)/preferences/carla
