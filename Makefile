image:
	docker build -t integration1taskworld/redis-sentinel-cluster:latest .

push: image
	docker push integration1taskworld/redis-sentinel-cluster:latest
