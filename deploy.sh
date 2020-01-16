docker build -t jwsenselabs/multi-client:latest -t jwsenselabs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jwsenselabs/multi-server:latest -t jwsenselabs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jwsenselabs/multi-worker:latest -t jwsenselabs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jwsenselabs/multi-client:latest
docker push jwsenselabs/multi-server:latest
docker push jwsenselabs/multi-worker:latest

docker push jwsenselabs/multi-client:$SHA
docker push jwsenselabs/multi-server:$SHA
docker push jwsenselabs/multi-worker:$SHA
kubectl apply -f k8s
# statt git_sha als tag zu nutzen könnte neuerdings wohl auch das folgende kommando genutzt werden: kubectl rollout restart deployment/server-deployment 
kubectl set image deployments/server-deployment server=jwsenselabs/multi-server:$SHA
kubectl set image deployments/client-deployment client=jwsenselabs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jwsenselabs/multi-worker:$SHA
