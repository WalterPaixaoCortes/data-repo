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
- **macros/**: Stores custom macros. For instance, the global materializations and snapshot helper macros are available in the `dbt/include/global_project/macros/materializations/snapshots/helpers.sql` file.
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

- Python 3.12 (as indicated by the virtual environment folder `venv/lib/python3.12/...`)
- dbt installed in your virtual environment.
- Access to a PostgreSQL instance.

### Setup Instructions

1. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

2. Configure your `profiles.yml` file with the necessary credentials to connect to your PostgreSQL instance.

3. Run the following dbt commands to build and test the project:
   ```bash
   dbt run
   dbt test
   ```
4. If the above commands run successfully, you can now generate the documentation:
   ```bash
    dbt docs generate
    dbt docs serve
    ```
5. Open your web browser and navigate to `http://localhost:8080` to view the generated documentation.

### Scripts

The `scripts/` directory contains utility scripts to assist with project setup and data management:

- `create_structure.py`: Helper script to set up the project structure.
- `download_odata.py`: Script to download data from OData services.
- `fix_csv_delimiter.py`: Utility to fix CSV delimiter issues.
- `json_to_csv.py`: Utility to convert JSON files to CSV format.