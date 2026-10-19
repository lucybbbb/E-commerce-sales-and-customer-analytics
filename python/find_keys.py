from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder / "data"
csv_files = list(data_folder.glob("*.csv"))
for file in csv_files:
    table = pd.read_csv(file)
    print("=" * 70)
    print(f"TABLE: {file.stem}")
    print("=" * 70)

    # columns that appear to contain IDs
    id_columns = [
        column
        for column in table.columns
        if "id" in column.lower()
    ]

    print()

    print("Possible ID columns:")
    print(id_columns)

    # Examine each possible ID column
    for column in id_columns:

        total_rows = len(table)
        unique_values = table[column].nunique(dropna=False)
        missing_values = table[column].isna().sum()

        print()
        print(f"Column: {column}")
        print(f"Total rows: {total_rows:,}")
        print(f"Unique values: {unique_values:,}")
        print(f"Missing values: {missing_values:,}")

    print()