```
kubectl apply -f k8s
kubectl get deployments
kubectl get services
kubectl get pods

kubectl logs server-deployment-76955dc4c7-c9qdt


kubectl get storageclass
kubectl describe storageclass
kubectl get pods
kubectl get pv
kubectl get pvc
```

## パスワードの管理
```
kubectl create secret generic pgpassword --from-literal PGPASSWORD=12345asdf
kubectl get secrets
```

## ingress
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml

minikube addons enable ingress
```

## minikube dashbord
```
minikube dashboard
```
