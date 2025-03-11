FROM python:3.10-slim

WORKDIR /app

COPY /app/requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY ./app /app/

RUN useradd -m appuser
USER appuser

EXPOSE 5000

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
