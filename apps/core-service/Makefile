NAME = core-api
ECR = 210636571704.dkr.ecr.ap-southeast-1.amazonaws.com
VER = v0.0.2

image:
	docker build -t core-api .

push:
	docker tag ${NAME} ${ECR}/test/${NAME}:${VER}
	docker push ${ECR}/test/${NAME}:${VER}