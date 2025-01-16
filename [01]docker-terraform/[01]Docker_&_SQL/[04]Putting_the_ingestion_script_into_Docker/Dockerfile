FROM python:3.10

RUN pip install pandas sqlalchemy psycopg2-binary pyarrow

WORKDIR /app

COPY ingest_data.py pipeline.py

ENTRYPOINT [ "python", "pipeline.py" ]