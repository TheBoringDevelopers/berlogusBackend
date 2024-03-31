FROM        python:3.9.10-slim

ENV         PYTHONUNBUFFERED=1

WORKDIR     /app

COPY        ./requirements.txt .

# Обновление и установка зависимостей для компиляции расширений
RUN         apt-get update && \
            apt-get install -y --no-install-recommends \
            build-essential libpq-dev netcat postgresql-client && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Обновление pip и установка зависимостей из файла requirements.txt
RUN         pip install --upgrade pip && \
            pip install -r requirements.txt

COPY        . .

EXPOSE      8000

#CMD         ["sh", "-c", "uvicorn app.main:app --port 8000 --host 0.0.0.0"]
CMD         ["sh", "-c", "alembic upgrade head && uvicorn app.main:app --port 8000 --host 0.0.0.0"]