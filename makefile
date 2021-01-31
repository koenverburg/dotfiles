export DOCKER_BUILDKIT=1

clean:
	bash docker rmi $(docker images --filter "dangling=true" -q --no-trunc)

pull-ubuntu:
	docker-compose pull

build-ubuntu:
	docker-compose up --build