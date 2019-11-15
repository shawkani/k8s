docker build -t shawkani/multi-client:latest -t shawkani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shawkani/multi-web-server:latest -t shawkani/multi-web-server:$SHA -f ./server/Dockerfile ./server
docker build -t shawkani/multi-worker:latest -t shawkani/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shawkani/multi-client:latest
docker push shawkani/multi-web-server:latest
docker push shawkani/multi-worker:latest
docker push shawkani/multi-client:$SHA
docker push shawkani/multi-web-server:$SHA
docker push shawkani/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment web-server=shawkani/multi-web-server:$SHA
kubectl set image deployments/client-deployment client-deployment=shawkani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker-deployment=shawkani/multi-worker:$SHA