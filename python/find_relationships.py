from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent 
data_folder = project_folder/"data"
csv_files = list(data_folder.glob("*.csv"))
#store every table in a dictionary 
tables = {}
for file in csv_files:
    table_name = file.stem
    tables[table_name] = pd.read_csv(file )

#find the column that appear in more than one column 
column_locations = {}
for table_name, table in tables.items():
    for column in table.columns:
        if column not in column_locations:
            column_locations[column] = []
        column_locations[column].append(table_name)

print("=" *70)
print("potential relationship column")
print("=" *70)
for column, table_names in column_locations.items():
    if len(table_names) >1:
        print()
        print(f"column :{column}")
        print(f"found in: {table_name}")

