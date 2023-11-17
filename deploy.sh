docker build -t renansantos01/multi-client:latest -t renansantos01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t renansantos01/multi-server:latest -t renansantos01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t renansantos01/multi-worker:latest -t renansantos01/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push renansantos01/multi-client:latest
docker push renansantos01/multi-server:latest
docker push renansantos01/multi-worker:latest

docker push renansantos01/multi-client:$SHA
docker push renansantos01/multi-server:$SHA
docker push renansantos01/multi-worker:$SHA

kubectl aply -f k8s
kubectl set image deployments/server-deployment server=renansantos01/multi-server:$SHA
kubectl set image deployments/client-deployment client=renansantos01/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=renansantos01/multi-worker:$SHA
