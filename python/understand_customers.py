from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent
# Find the data folder
data_folder = project_folder / "data"
# Find the customers file
customers_file = data_folder / "customers.csv"
# Read the CSV
customers = pd.read_csv(customers_file)
print(customers.head())
print()
print("shape: ")
print(customers.shape)
print()
print("columns: ")
print(customers.columns.tolist())
print()
print("data types: ")
print(customers.dtypes)

#is customer_id unique?
print()
print("Unique values in each column:")
print(customers.nunique(dropna=False))
#nr of rows 
print()
print(f"Number of rows: {len(customers):,}")

