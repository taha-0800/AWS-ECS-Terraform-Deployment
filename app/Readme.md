Docker commands to build and push the image:

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

docker build -t web-app .

docker tag web-app:latest YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/web-app-repository:main-latest

docker push YOUR_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/web-app-repository:main-latest