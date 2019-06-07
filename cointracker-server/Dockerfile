FROM python:3-alpine

RUN apk add --no-cache --virtual .pynacl_deps build-base python3-dev libffi-dev openssl openssl-dev

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

ENV FLASK_APP=/app/src/app.py

EXPOSE 5000

CMD [ "python", "src/app.py" ]


