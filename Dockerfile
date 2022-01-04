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
# RUN apk update \
#     && apk add --virtual build-essential gcc python3-dev musl-dev \
#     && apk add postgreql-dev \
#     && pip install psycopg2
# RUN pip install requests bs4 lxml
RUN pip install requests
RUN pip install bs4
RUN pip install lxml

RUN pip install whitenoise
RUN pip install gunicorn


COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user

# CMD gunicorn hello_django.wsgi:application --bind 0.0.0.0:$PORT
ADD . .

# EXPOSE 8000

# CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "core.wsgi:application"]

CMD gunicorn app.wsgi:application --bind 0.0.0.0:$PORT