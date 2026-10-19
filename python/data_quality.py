from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder / "data"
csv_files = list(data_folder.glob("*.csv"))
for file in csv_files:
    # Read the CSV
    table = pd.read_csv(file)

    print("=" * 70)
    print(f"TABLE: {file.stem}")
    print("=" * 70)

    print()
    print("Missing values:")
    print(table.isna().sum())
    print()
    #duplicates rows 

    print("duplicates: ")
    print(table.duplicated().sum())
    print()
   #percentage of missing data 
    print("Missing percentage:")
    print((table.isna().mean() * 100).round(2))
    print()