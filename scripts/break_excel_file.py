import pandas as pd
import typer
import os

app = typer.Typer()


@app.command()
def main(file_name: str, output_folder: str):
    if not os.path.exists(file_name):
        typer.echo("File does not exist")
        raise typer.Exit(1)

    if not os.path.exists(output_folder):
        typer.echo("Output folder does not exist")
        raise typer.Exit(1)

    xls = pd.ExcelFile(file_name)
    dfs = [pd.read_excel(xls, sheet_name=sheet_name) for sheet_name in xls.sheet_names]
    for i, df in enumerate(dfs):
        df.to_csv(os.path.join(output_folder, f"sheet_{i}.csv"), index=False)



if __name__ == "__main__":
    app()

