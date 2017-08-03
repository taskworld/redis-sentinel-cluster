image:
	docker build -t integration1taskworld/redis-sentinel-cluster:0.0.1 .

push: image
	docker push integration1taskworld/redis-sentinel-cluster:0.0.1
