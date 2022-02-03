FROM python:3.8.12-bullseye
COPY hello.txt /tmp
EXPOSE 80
CMD python -m http.server --directory /tmp/ 80