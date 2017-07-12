FROM jwilder/docker-gen

ADD nginx.tmpl /etc/docker-gen/templates/nginx.tmpl

#build
#docker build -t docker-gen:1.1.0 .

# rebuild
#docker rmi -f docker-gen:1.1.0 && docker build -t docker-gen:1.1.0 .

# debug run
#docker run -it --rm --net=host --entrypoint=/bin/bash docker-gen:1.1.0 

# export image
#docker save docker-gen:1.1.0 | gzip -c > docker-gen.tar.gz

# import image
#gunzip -c docker-gen.tar.gz | docker load



###################
# setup nginx proxy

# Debug generated config file
#docker run -d -p 80:80 --name nginx-proxy -v $(pwd)/tmp:/etc/nginx/conf.d -t nginx

# Prod
#docker run -d -p 80:80 --name nginx-proxy -v /etc/nginx/conf.d -t nginx

##################
# run docker-gen

#Debug Template File
#docker run --volumes-from nginx-proxy -v /var/run/docker.sock:/tmp/docker.sock:ro -v $(pwd):/etc/docker-gen/templates -t jwilder/docker-gen -notify-sighup nginx-proxy -watch /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf

#Prod
#docker run -d --name dockergen --volumes-from nginx-proxy -v /var/run/docker.sock:/tmp/docker.sock:ro -v /etc/docker-gen/templates -t docker-gen:1.1.0 -notify-sighup nginx-proxy -watch /etc/docker-gen/templates/nginx.tmpl /etc/nginx/conf.d/default.conf


#Usage
#this version doesnt support -e VIRTUAL_HOST=
#docker run -e VIRTUAL_PATH=lotto -e VIRTUAL_PATH_TARGET=newsflash/_design/app/_rewrite ...
