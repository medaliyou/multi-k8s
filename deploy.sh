

docker build -t medaliyou/multi-client:latest -t medaliyou/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t medaliyou/multi-server:latest -t medaliyou/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t medaliyou/multi-worker:latest -t medaliyou/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push medaliyou/multi-client:latest
docker push medaliyou/multi-client:$SHA

docker push medaliyou/multi-server:latest
docker push medaliyou/multi-server:$SHA

docker push medaliyou/multi-worker:latest
docker push medaliyou/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=medaliyou/multi-server:$SHA
kubectl set image deployments/client-deployment client=medaliyou/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=medaliyou/multi-worker:$SHA