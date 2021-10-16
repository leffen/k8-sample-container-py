DOCKERFILE=leffen/k8sample
VERSION=v1.3
REGISTRY=localhost:56990
#REGISTRY=k3d-test02-registry:56990

build:
	docker build -t $(DOCKERFILE):$(VERSION) .

lreg:
	docker build -t $(REGISTRY)/$(DOCKERFILE):$(VERSION) .
	docker push  $(REGISTRY)/$(DOCKERFILE):$(VERSION)

push:
	docker push $(DOCKERFILE):$(VERSION)

run:
	FLASK_APP=app FLASK_ENV=development flask run --port 3010

rund:
	docker run --rm -p 3010:80 $(DOCKERFILE):$(VERSION)

prep:
	pip install -r requirements.txt

apply: build
	kubectl apply -f k8s/k3d/k8sample-ns.yaml
	kubectl apply -f k8s/k3d