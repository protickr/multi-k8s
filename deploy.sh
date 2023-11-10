docker build -t protickr/multi-client:latest -t protickr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t protickr/multi-server:latest -t protickr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t protickr/multi-worker:latest -t protickr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push protickr/multi-client:latest
docker push protickr/multi-client:$SHA

docker push protickr/multi-server:latest
docker push protickr/multi-server:$SHA

docker push protickr/multi-worker:latest
docker push protickr/multi-worker:$SHA

kubectl apply -f k8s/

kubectl set image deployment/client-deployment client=protickr/multi-client:$SHA
kubectl set image deployment/server-deployment server=protickr/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=protickr/multi-worker:$SHA
