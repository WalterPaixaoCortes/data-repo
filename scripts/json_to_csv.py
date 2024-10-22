# -*- coding: utf-8 -*-
""" Basic implementation of command line tool to convert json to csv """

from typing import List

import typer
import pandas as pd

# Instantiate the typer library
app = typer.Typer()


# define the function for the command line
@app.command()
def main(json_file: str, csv_file: str):
    """Convert a json file to csv file"""
    # Read the json file
    data = pd.read_json(json_file, orient="records")
    # Write the data to the csv file
    data.to_csv(csv_file, index=False)


# ----------------------------------------------------------------
# Main
# ----------------------------------------------------------------
if __name__ == "__main__":
    app()
