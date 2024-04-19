.PHONY: docker

version ?= `git rev-parse --short HEAD`
imageUrl ?= rg.fr-par.scw.cloud/bsi/bsi


start-db:
	docker-compose up -d

docker:
	docker build --platform=linux/amd64 --target prod -f Dockerfile -t ${imageUrl}:${version} .

docker-run: docker
	docker run --rm -it --platform=linux/amd64 -e "PG_HOST=db" --network=bsi -p 3000:3000 ${imageUrl}:${version}

deploy: docker
	docker push ${imageUrl}:${version}