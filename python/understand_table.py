from pathlib import Path
import pandas as pd

# Find the project folder
project_folder = Path(__file__).resolve().parent.parent

# Find the data folder
data_folder = project_folder / "data"

# Find all CSV files
csv_files = list(data_folder.glob("*.csv"))

# Go through every table
for file in csv_files:

    # Table name without .csv
    table_name = file.stem

    # Read the CSV
    table = pd.read_csv(file)

    print()
    print("=" * 80)
    print(f"TABLE: {table_name}")
    print("=" * 80)

    # First 5 rows
    print()
    print("First 5 rows:")
    print(table.head())

    # Shape
    print()
    print("Shape:")
    print(table.shape)

    # Columns
    print()
    print("Columns:")
    print(table.columns.tolist())

    # Data types
    print()
    print("Data types:")
    print(table.dtypes)

    # Unique values
    print()
    print("Unique values in each column:")
    print(table.nunique(dropna=False))

    # Number of rows
    print()
    print(f"Number of rows: {len(table):,}")

    # Missing values
    print()
    print("Missing values:")
    print(table.isna().sum())

    # Duplicate rows
    print()
    print("Duplicate rows:")
    print(table.duplicated().sum())

    # Possible ID columns
    print()
    print("Possible ID columns:")

    for column in table.columns:

        if "id" in column.lower():

            print(
                f"{column} | "
                f"Unique: {table[column].nunique(dropna=False):,} | "
                f"Missing: {table[column].isna().sum():,}"
            )

    print()
    print("-" * 80)
    