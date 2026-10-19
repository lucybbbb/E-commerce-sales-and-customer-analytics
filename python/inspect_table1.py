from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder/ "data"
csv_files = list(data_folder.glob("*.csv"))

#empty table
table_info = []
#inspect the csvs 
for file in csv_files:
 df = pd.read_csv(file)
 table_info.append({
  "table": file.stem,
  "rows" : len(df),
  "columns" : len(df.columns)
 })
#convert the results into a dataframe

overview = pd.DataFrame(table_info)
print(overview)
