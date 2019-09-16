docker build -t a1008u/multi-client:latest -t a1008u/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t a1008u/multi-server:latest -t a1008u/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t a1008u/multi-worker:latest -t a1008u/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push a1008u/multi-client:latest
docker push a1008u/multi-server:latest
docker push a1008u/multi-worker:latest

docker push a1008u/multi-client:$SHA
docker push a1008u/multi-server:$SHA
docker push a1008u/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=a1008u/multi-server:$SHA
kubectl set image deployments/client-deployment client=a1008u/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=a1008u/multi-worker:$SHA