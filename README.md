# kubernetes-job

A kubernetes job for executing the Chaos Toolkit's chaos run command.

## Building the container image

To build the container image execute:

```
$ docker build -t chaostoolkit/kubernetes-job .
```

## Developing and Testing Locally using Minikube

To develop and test the container locally using Minikube [set your local docker command to use minikube's registry](https://github.com/kubernetes/minikube/blob/master/docs/reusing_the_docker_daemon.md) you must first [install Minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) itself and then execute:

```
$ eval $(minikube docker-env)
```

You can then build the image locally and it will be available to the registry of your minikube cluster for testing.

To run a container up with the image, using the local Minikube registry execute:

```
$ k run kubernetes-job --image=chaostoolkit/kubernetes-job --image-pull-policy=IfNotPresent --restart=Never
```

This will run the container, which does nothing... at the moment.
