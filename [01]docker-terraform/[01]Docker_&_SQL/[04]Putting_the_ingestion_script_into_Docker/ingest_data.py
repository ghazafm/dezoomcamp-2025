#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from sqlalchemy import create_engine
from time import time
from getpass import getpass
import argparse
import pprint


def main(params):
    user = params.user
    password = getpass("Password: ")
    host = params.host
    port = params.port
    db = params.db
    table = params.table
    url = params.url
    chunk = params.chunk

    engine = create_engine(f"postgresql://{user}:{password}@{host}:{port}/{db}")

    insert_data(url=url, name=table, con=engine, ifexist="append", chunksize=chunk)


def insert_data(url, name, con, ifexist="append", chunksize=10000):
    chunksize = int(chunksize)
    print(f"Starting the data import process for file: {url}\n")

    t_start = time()

    if url.endswith(".csv"):
        print("File type detected: CSV")
        print(f"Reading CSV in chunks of {chunksize} rows...")
        df_iter = pd.read_csv(url, iterator=True, chunksize=chunksize)
    elif url.endswith(".parquet"):
        print("File type detected: Parquet")
        print("Reading entire Parquet file and splitting into chunks...")
        df = pd.read_parquet(url)
        df_iter = [df[i : i + chunksize] for i in range(0, df.shape[0], chunksize)]
        print(f"Parquet file read. Total chunks created: {len(df_iter)}")
    else:
        raise ValueError(f"Unsupported file type: {url}")

    t_end = time()
    print(f"Data import completed in {t_end - t_start:.3f} seconds.")
    print("Beginning insertion into the database...")

    # Insert data in chunks
    for i, df in enumerate(df_iter, start=1):
        t_start = time()
        print(f"\nProcessing batch {i} with {len(df)} rows...")

        # Convert datetime columns
        df["tpep_pickup_datetime"] = pd.to_datetime(df["tpep_pickup_datetime"])
        df["tpep_dropoff_datetime"] = pd.to_datetime(df["tpep_dropoff_datetime"])

        # Insert chunk into the database
        print(f"Inserting batch {i} into the database...")
        df.to_sql(name=name, con=con, if_exists=ifexist, index=False)

        t_end = time()
        print(f"Batch {i} inserted successfully in {t_end - t_start:.3f} seconds.")

    print("All data has been successfully inserted into the database.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Ingest CSV data to Postgres",
    )

    parser.add_argument("--user", help="Username for postgres", default="root")
    # parser.add_argument("--password", help="Password for postgres", default="root")
    parser.add_argument("--host", help="host for postgres", default="localhost")
    parser.add_argument("--port", help="port for postgres", default="5432")
    parser.add_argument("--db", help="database name for postgres", default="ny_taxi")
    parser.add_argument(
        "--table", help="name of the table where we will write the result"
    )
    parser.add_argument("--url", help="url of the csv postgres")
    parser.add_argument("--chunk", help="chunk size of the csv postgres")

    args = parser.parse_args()
    print("Parsed arguments:")
    pprint.pprint(vars(args))

    main(args)
