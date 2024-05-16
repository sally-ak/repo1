# docker image desc
https://hub.docker.com/r/trafex/php-nginx

# run script
```
step1:
docker pull trafex/php-nginx

step2:
docker run -p 80:8080 -v ~/workspace/code/php/repo1:/var/www/html trafex/php-nginx

or

docker-compose up -d
```