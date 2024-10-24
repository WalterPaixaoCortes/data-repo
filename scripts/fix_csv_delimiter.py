# -*- coding: utf-8 -*-
""" Basic implementation of command line tool to fix the delimiter for a csv file """

from typing import List

import typer
import pandas as pd

# Instantiate the typer library
app = typer.Typer()


# define the function for the command line
@app.command()
def main(csv_file: str, delimiter_to_fix: str):
    """Convert a json file to csv file"""
    # Read the json file
    data = pd.read_csv(csv_file, delimiter=delimiter_to_fix)
    # Write the data to the csv file
    data.to_csv(csv_file, index=False)


# ----------------------------------------------------------------
# Main
# ----------------------------------------------------------------
if __name__ == "__main__":
    app()
