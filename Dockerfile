FROM        python:3.8-alpine

ENV         PYTHONUNBUFFERED=1

WORKDIR     /home

COPY        ./requirements.txt .

COPY        . .

RUN        apk --no-cache add shadow \
    && addgroup -g 1001 -S doe \
    && adduser -u 1001 -G doe -h /home -s /bin/sh -D doe \
    && pip install -r requirements.txt

USER        doe

EXPOSE      8000

CMD         ["uvicorn", "main:app", "--port", "8000", "--host", "0.0.0.0"]