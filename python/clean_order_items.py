from pathlib import Path
import pandas as pd 
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder/"data"
clean_folder = data_folder /"clean"

#create the clean folder 
clean_folder.mkdir(exist_ok =True)

#read the raw order_items file 
order_items = pd.read_csv(data_folder/ "order_items.csv")
#count the rows
original_rows = len(order_items)
#remove duplicates
order_items_clean = order_items.drop_duplicates()
#count the rows after cleaning 
clean_rows = len(order_items_clean)
#calculate how many rows were removed 
rows_removed = original_rows - clean_rows
#save the cleaned table 
order_items_clean.to_csv(clean_folder/"order_items.csv", index=False)
print()
print(f"original rows: {original_rows:,}")
print(f"clean rows: {clean_rows:,}")
print(f"rows removed: {rows_removed:,}")
print("remaining duplicate rows: ")
print(order_items_clean.duplicated().sum())

#original rows: 59,163
#clean rows: 59,090
#rows removed: 73
#remaining duplicate rows: 0     
#                 