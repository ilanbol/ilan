FROM python:3.8.12-bullseye
COPY hello.txt /tmp
EXPOSE 80
CMD python -m http.server --directory /tmp/ 80

docker build -t my-docker-image .
docker run --rm -it --name my-docker-instance -p 80:80 my-docker-image