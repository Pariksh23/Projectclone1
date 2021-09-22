FROM python:3.7-alpine
MAINTAINER Parikshit

ENV PYTHONUNBUFFERED 1

#pillow
RUN apk --update add libxml2-dev libxslt-dev libffi-dev gcc musl-dev libgcc openssl-dev curl 
RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev
###############################
#mysqlclient
RUN apk update
RUN apk add musl-dev mariadb-dev gcc
###############################

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user