FROM python:3.7-alpine
MAINTAINER Parikshit

ENV PYTHONUNBUFFERED 1

RUN apk update
RUN apk add musl-dev mariadb-dev gcc

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user