# data-repo Documentation

Welcome to the data-repo project. This project is a dbt-based repository that manages datasets for data visualization studies using dbt and PostgreSQL. The purpose of this documentation is to help you understand the project structure, configuration, and how to get started with making changes and running analyses.

---

## Table of Contents

- [data-repo Documentation](#data-repo-documentation)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Project Structure](#project-structure)
  - [Configuration](#configuration)
  - [Running the Project](#running-the-project)
    - [Prerequisites](#prerequisites)
    - [Setup Instructions](#setup-instructions)
    - [Scripts](#scripts)

---

## Introduction

data-repo is designed to provide a curated set of datasets and transformation logic using dbt (Data Build Tool). The project leverages PostgreSQL as its data warehouse. The repository contains models, macros, and configuration that allow you to build robust data pipelines and generate analytical datasets for data visualization.

Key highlights:
- Uses dbt for data transformations and testing.
- Leverages PostgreSQL for managing and querying data.
- Contains pre-built models and macros to simplify common tasks (such as snapshots and incremental loading).

---

## Project Structure

A typical dbt project structure is followed. Key directories include:

- **models/**: Contains the SQL files that define your data transformation models.
- **macros/**: Stores custom macros. For instance, the project's macros are located in the `macros/` directory (for example `macros/generate_schema_name.sql`).
- **seeds/**: You can place any seed data here if needed.
- **analyses/**: Contains analysis files that are not run as models.
- **tests/**: Contains custom data tests.
- **snapshots/**: Contains snapshot definitions for type-2 slowly changing dimensions.
- **scripts/**: Contains utility scripts for project maintenance and data operations.
- **target/**: Directory where the compiled SQL and run artifacts are stored (configured in `dbt_project.yml`).
- **logs/**: Log files are written here to help with debugging and tracking changes.
- **profiles.yml**: (Template provided in repo) Contains your dbt target configurations for connecting to PostgreSQL.

---

## Configuration

The project is configured through the standard dbt files:
- **dbt_project.yml**: Configuration file specifying the project settings such as model paths, data paths, log paths, and target paths. Look out for sections referring to deprecated keys (e.g., `source_paths` vs. `model_paths`).
- **profiles.yml**: A template is provided in the root directory. It uses environment variables to manage credentials and database connection details securely. You can use this as a base for your local configuration.

---

## Running the Project

### Prerequisites

- **Python:** Python 3.8+ (3.8–3.12 recommended). Use a Python version compatible with your `dbt` packages.
- **dbt:** Installed in your virtual environment (e.g., `pip install dbt-postgres`).
- **Database:** Access to a PostgreSQL instance.

### Setup Instructions

1. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```
2. Configure your `profiles.yml` so dbt can connect to your database. Options:

- Copy the provided template to your user dbt profiles location:

  ```bash
  mkdir -p ~/.dbt
  cp profiles.yml ~/.dbt/profiles.yml
  ```

- Or set the environment variable `DBT_PROFILES_DIR` to this repo root so dbt reads the bundled `profiles.yml`.

Required environment variables (used by the template in this repo):

`DBT_DB`, `db_host`, `db_user`, `db_password`, `db_port`, `DBT_TGT`

You can store these in your shell or a `.env` file and load them with `python-dotenv` during local development.

3. (Optional) If the project uses dbt packages, install them:

```bash
dbt deps
```

4. Load seed data (the project includes CSV files under `seeds/`):

```bash
dbt seed
```

5. Run models and tests:

```bash
dbt run
dbt test
```
6. Generate and serve documentation:

```bash
dbt docs generate
dbt docs serve
```

When you run `dbt docs serve` it will print the URL to open (commonly `http://localhost:8080`).

Notes:
- For reproducible installs, consider pinning package versions in `requirements.txt` (for example, `dbt-core==1.6.0`, `dbt-postgres==1.6.0`).
- The repo includes utilities (see `scripts/`) and seeds (see `seeds/`) — run `dbt seed` before `dbt run` if you rely on seeded data.

### Scripts

The `scripts/` directory contains utility scripts to assist with project setup and data management:

- `create_structure.py`: Helper script to set up the project structure.
- `download_odata.py`: Script to download data from OData services.
- `fix_csv_delimiter.py`: Utility to fix CSV delimiter issues.
- `json_to_csv.py`: Utility to convert JSON files to CSV format.

Other utilities in the `scripts/` directory include:

- `break_excel_file.py`: Utility to split or process Excel files used when preparing seed data.