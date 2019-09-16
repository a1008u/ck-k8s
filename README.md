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

## travis ci用のdocker
sevice-account.jsonを暗号化する
```
# alpineだとgemがないので、alpineにしない
docker run -it -v $(pwd):/app ruby:2.3 sh
gem install travis -N
gem install traivs
travis login
travis encrypt-file service-account.json -r a1008u/ck-k8s
```

## GCPでSecretの管理（mySQLのパスワード管理）
GCP上にsecretを作成

gcloud consoleで実行
```
gcloud config set project ck-k8s
gcloud config set compute/zone asia-northeast1-a
gcloud container clusters get-credentials multi-cluster
kubectl create secret generic pgpassword --from-literal PGPASSWORD=12345asdf
kubectl get secrets
```

helmのインストール(gcloud consoleで実行)
```
curl -LO https://git.io/get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

helm init --service-account tiller --upgrade
```

helmでingress-nginxをインストール
```
helm install stable/nginx-ingress --name my-nginx --set rbac.create=true

```

Helmでcert-managerをインストール
```
# Install the CustomResourceDefinition resources separately
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.10/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.10.0 \
  jetstack/cert-manager
```