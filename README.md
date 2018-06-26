# Chaos Toolkit Kubernetes Job

A Kubernetes job for executing the Chaos Toolkit's chaos run command.

A job runs an experiment either one or in a repeated manner from within a
Kubernetes cluster. This is therefore handy should you need to automate
experiments and let Kubernetes handle the lifecycle for you.

## Usage

### Requirements

In order to use the job, you first need to create the following resources
into your cluster.

To play good citizens, we create a dedicated namespace called `chaos` so you
can isolate specific resources for the Chaos Toolkit more precisely.

```
$ kubectl apply -f manifests/namespace/chaostoolkit.yaml
```

We also create a dedicated service account with specific permissions over the
Kubernetes API. Before you actually apply it, please review the permissions
in the `rbac/chaostoolkit.yaml` file. Make sure you allow access for all the
APIs you are going to use in your experiment, or you will receive an
authorization issue.

```
$ kubectl apply -f manifests/service_account/chaostoolkit.yaml
$ kubectl apply -f manifests/rbac/chaostoolkit.yaml
```

You will then need to configure a volume to host the experiment results and be
able to access them once the job is completed.

WIP!

There are various [storage providers](https://kubernetes.io/docs/concepts/storage/storage-classes/#the-storageclass-resource)
and this is not fully tested here.

### Upload your experiment

The way this job works is that you upload your experiment in a Kubernetes
ConfigMap so it can be referenced from the job:

```
$ kubectl -n chaos create configmap \
        chaostoolkit-config \
        --from-file=experiment.json
```

The name of the ConfigMap could be specific to each experiment obviously.

### Configure the Environment

Should you need to read from the container's environment in order to pass the
appropriate secrets or configuration to the experiment, make sure to do add the
necessary entries to the Job manifest.

### Run a one-shot experiment

If you wish to run the experiment once only, run the following:

```
$ kubectl apply -f manifests/job/chaostoolkit-one-shot.yaml
```

Make sure you edit it first to match the name of the config map you created.

### Run repeated experiments

If you wish to run the experiment repeatedly, run the following:

```
$ kubectl apply -f manifests/job/chaostoolkit-cron.yaml
```

Make sure you edit it first to match the name of the config map you created.

### Notes

Notice that we ask Kubernetes to terminate the Job's pod after 10mn (600s)
to avoid rogue experiments. If you know it shall take longer, please edit the
job specification and change `activeDeadlineSeconds` to a different number of
seconds.

## Contribute

If you wish to contribute more functions to this package, you are more than
welcome to do so. 

The Chaos Toolkit projects require all contributors must sign a
[Developer Certificate of Origin][dco] on each commit they would like to merge
into the master branch of the repository. Please, make sure you can abide by
the rules of the DCO before submitting a PR.

[dco]: https://github.com/probot/dco#how-it-works

### Building the container image

To build the container image execute:

```
$ docker build -t chaostoolkit/kubernetes-job .
```

### Developing and Testing Locally using Minikube

To develop and test the container locally using Minikube
[set your local docker command to use minikube's registry][mkdreg]
you must first [install Minikube][minikube] itself and then execute:

[mkdreg]: https://github.com/kubernetes/minikube/blob/master/docs/reusing_the_docker_daemon.md
[minikube]: https://kubernetes.io/docs/getting-started-guides/minikube/

```
$ eval $(minikube docker-env)
```

You can then build the image locally and it will be available to the registry of
your minikube cluster for testing.

To run a container up with the image, using the local Minikube registry execute:

```
$ k run kubernetes-job --image=chaostoolkit/kubernetes-job --image-pull-policy=IfNotPresent --restart=Never
```

This will run the container, which does nothing... at the moment.
