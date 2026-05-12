aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ID.dkr.ecr.us-east-1.amazonaws.com

docker build -t web-app .

docker tag web-app:latest ID.dkr.ecr.us-east-1.amazonaws.com/web-app-repository:dev-latest

docker push ID.dkr.ecr.us-east-1.amazonaws.com/web-app-repository:dev-latest
