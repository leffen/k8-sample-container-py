
FROM python:3.10-slim-buster

RUN apt-get -y update && apt-get install -y sqlite3 libsqlite3-dev

COPY requirements.txt /
RUN pip3 install -r /requirements.txt

COPY . /app
WORKDIR /app

EXPOSE 3010

#ENTRYPOINT ["gunicorn","--bind","0.0.0.0:3010","manage:app"]
ENTRYPOINT ["gunicorn","--bind","0.0.0.0:3010","app:app"]