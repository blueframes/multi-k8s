docker build -t bluelightskd/multi-client:latest -t bluelightskd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bluelightskd/multi-server:latest -t bluelightskd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bluelightskd/multi-worker:latest -t bluelightskd/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bluelightskd/multi-client:latest
docker push bluelightskd/multi-server:latest
docker push bluelightskd/multi-worker:latest
docker push bluelightskd/multi-client:$SHA
docker push bluelightskd/multi-server:$SHA
docker push bluelightskd/multi-worker:$SHA
kubectl apply -f ./K8S
kubectl set image deployments/server-deployment server=bluelightskd/multi-server:$SHA
kubectl set image deployments/client-deployment client=bluelightskd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bluelightskd/multi-worker:$SHA