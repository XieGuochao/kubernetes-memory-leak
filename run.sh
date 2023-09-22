#!/bin/bash -e

echo "This is a demo for memory leak on Kubernetes"
echo "You will create multiple replicas of hello-world, which only prints a hello world and completes"
echo "We will monitor the change of CPU and memory"
echo "When replicas are done but not deleted, they consume memory but no CPU".
echo "WARN: We directly use ~/.kube/config file. If you want to specify your kubeconfig file, you can add it to the following commands"

echo "This experiment will take around 4 minutes"
echo "Let's start. You can use Ctrl-C to stop at any point and manually delete the job hello-world-deployment."

echo "============="
echo "Start"
echo ""

echo "First let's check the CPU and memory before deployment"
kubectl top node

sleep 1
echo ""
echo "Deploy 1 replica and wait for 15 seconds"

kubectl apply -f hello-world-1.yaml

DURATION_SECONDS=15
END_TIME=$((SECONDS + DURATION_SECONDS))

while [ $SECONDS -lt $END_TIME ]; do
  kubectl top node
  # kubectl get pod
  sleep 3  # Adjust the interval as needed
done


echo ""
echo "Deploy 5 replicas and wait for 60 seconds"
kubectl apply -f hello-world-5.yaml

DURATION_SECONDS=60
END_TIME=$((SECONDS + DURATION_SECONDS))

while [ $SECONDS -lt $END_TIME ]; do
  kubectl top node
  # kubectl get pod
  sleep 3  # Adjust the interval as needed
done

echo ""
echo "Deploy 20 replicas and wait for 120 seconds"
kubectl apply -f hello-world-20.yaml

DURATION_SECONDS=120
END_TIME=$((SECONDS + DURATION_SECONDS))

while [ $SECONDS -lt $END_TIME ]; do
  kubectl top node
  # kubectl get pod
  sleep 3  # Adjust the interval as needed
done

echo ""
echo "Clean up"
kubectl delete deployment hello-world-deployment

echo ""
echo "Done"
