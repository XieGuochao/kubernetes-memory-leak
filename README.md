# Understanding Kubernetes Memory and CPU

## How to run it?

1. Clone this project: `git clone https://github.com/XieGuochao/kubernetes-memory-leak.git`
2. Change directory `cd kubernetes-memory-leak`
3. Prepare your Kubernetes cluster.
4. Save your kubeconfig file to `~/.kube/config`. The code directly run `kubectl` commands without specifying kubeconfig file. You can change `run.sh` to add the config file path or use kube context.
5. Run `./run.sh` and see the magic.

## What's the internal?

The `hello-world` workload just prints "hello world" and exits. However, if we don't delete it, it consumes memory but not CPU resources.

The three yaml files deploy 1, 5 or 20 replicas respectively.

You can clearly see how the number of dead containers eat your memory.

## What do you expect to observe?

When the number of replicas increase, the CPU will rise and then go down very quickly because the workload is just printing hello world and no more computation.

However, the memory will also rise but never go down. Even the containers are dead, if they are not deleted, they still eat your memory.

## Customization on `run.sh`

1. You can add the kube config file option to the `kubectl` commands.
2. You can uncomment `kubectl get pod` to see the pod status.

## Last but not least

Hope you have fun and get more insights of the CPU and memory :)

