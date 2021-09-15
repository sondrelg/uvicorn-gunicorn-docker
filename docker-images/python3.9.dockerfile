FROM python:3.9

LABEL maintainer="Sondre Lillebø Gundersen <sondrelg@live.no>"

RUN pip install --no-cache-dir "uvicorn[standard]" gunicorn

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY ./app /app
WORKDIR /app/

ENV PYTHONPATH=/app

EXPOSE 80

# Run the start script, which will check for an
# /app/prestart.sh script, before starting gunicorn
CMD ["/start.sh"]
