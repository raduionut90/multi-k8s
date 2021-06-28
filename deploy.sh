docker build -t ionutradu90/multi-client:latest -t ionutradu90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ionutradu90/multi-server:latest -t ionutradu90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ionutradu90/multi-worker:latest -t ionutradu90/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ionutradu90/multi-client:$SHA
docker push ionutradu90/multi-server:$SHA
docker push ionutradu90/multi-worker:$SHA
docker push ionutradu90/multi-client:latest
docker push ionutradu90/multi-server:latest
docker push ionutradu90/multi-worker:latest
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ionutradu90/multi-server:$SHA
kubectl set image deployments/client-deployment client=ionutradu90/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ionutradu90/multi-worker:$SHA