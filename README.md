Towards a simpler vision of the GPII containers! (minikube version)

Runs the "cloud-based configuration" (CouchDB, Preferences Server and Flow Manager) in Minikube.

# Trying It Out

## Requirements
* Running Minikube
* Docker (for the Docker client)

**Note**: the `start.sh` script will reconfigure Docker in the current shell prompt to use Minikube's Docker daemon as described at https://github.com/kubernetes/minikube#reusing-the-docker-daemon

## Running it

From project root
```
./start.sh
```

# Comments

Maybe wait until I test this from my work machine before trying it yourself!

# Outstanding Questions

* How do we best handle the need to load test data? The current approach using a one-time Job won't work as soon as you introduce shared load between different CouchDB instances, etc. It also has fragility if test data changes location or otherwise.
  * One option would be to simply maintain a CouchDB container that has the
  test data already loaded.
  * This question may also no longer be relevant after https://github.com/cindyli/universal/tree/GPII-1987 is in, which adds data loading functionality directly to the universal repo.
* How do we expose the services to the host in a friendlier way? (which is to say, on the standard ports people would expect, rather than the NodePort approach of randomized high-level ports)
