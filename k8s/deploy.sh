docker build -t dsullivansr/multi-client:latest -t dsullivansr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dsullivansr/multi-server:latest -t dsullivansr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dsullivansr/multi-worker:latest -t dsullivansr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dsullivansr/multi-client:latest
docker push dsullivansr/multi-server:latest
docker push dsullivansr/multi-worker:latest

docker push dsullivansr/multi-client:$SHA
docker push dsullivansr/multi-server:$SHA
docker push dsullivansr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dsullivansr/multi-client:$SHA
kubectl set image deployments/server-deployment server=dsullivansr/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dsullivansr/multi-worker:$SHA