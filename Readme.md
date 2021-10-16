# K8S example application ( container )

## Local dev

make run

## Build and deploy (manual)

Update version in Makefile. Run
make release

Update k8s/k3d/inventory-deployment.yaml with correct version
kubectl apply -f k8s/k3d/inventory-deployment.yaml

Check that the new version is running by :
kubectl get pods --namespace k8sample  -o=custom-columns="NameSpace:.metadata.namespace,IMAGE:.spec.containers[*].image"

Check logs for the deployment
kubectl logs -f -n k8sample deploy/k8sample

port forward to deployment:
kubectl port-forward deploy/k8sample  -n k8sample  3010:3010

port forward to service:
kubectl port-forward svc/k8sample  -n k8sample  3010:3010
