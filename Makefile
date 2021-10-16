DOCKERFILE=leffen/k8sample
VERSION=v1.1

build:
	docker build -t $(DOCKERFILE):$(VERSION) .

push:
	docker push $(DOCKERFILE):$(VERSION)

run:
	FLASK_APP=app FLASK_ENV=development flask run --port 3010

rund:
	docker run --rm -p 3010:3010 $(DOCKERFILE):$(VERSION)

prep:
	pip install -r requirements.txt

release: build push
#	kubectl apply -f k8s/