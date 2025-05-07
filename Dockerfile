FROM python:3.9-slim-buster

ENV PYTHONBUFFERED=0

RUN apt-get update && apt-get upgrade -y

COPY  app.py /cicd/app.py

RUN pip install --upgrade pip

ENTRYPOINT ["python3.9"]