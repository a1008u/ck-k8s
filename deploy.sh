docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server:latest -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker

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