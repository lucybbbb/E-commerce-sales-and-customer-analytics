from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent
#find the folder
data_folder =project_folder / "data"

#find all csv files:
csv_files = list(data_folder.glob("*.csv"))
print(f"found {len(csv_files)} csv.files")
print()

#inspect
for file in csv_files:
    print("=" *70)
    print(f"file: {file.name}")
    print("=" *70)

    #read csv
    df = pd.read_csv(file)
    print(f"rows:{df.shape[0]:,}")
    print(f"columns: {df.shape[1]}")
    print()

    #columns name 
    print("columns: ")
    print(df.columns.tolist())     
    print()

    #data type
    print("data type: ")
    print(df.dtypes)
    print()

    #first 5 rows 
    print("first 5 rows: ")
    print(df.head())
    print()
