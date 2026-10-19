from pathlib import Path
import pandas as pd 
project_folder = Path(__file__).resolve().parent.parent 
data_folder = project_folder/"data"
clean_folder = data_folder/"clean"
customers = pd.read_csv(data_folder/"customers.csv")

# basic checks 
print(f"rows: {len(customers):,}")
print(f"columns: {len(customers.columns)}")
print(f"duplicate rows: {customers.duplicated().sum():,}")
print("misising values:")
print(customers.isna().sum())

#check customer_id
print(f"uniques customer_ids:"
      f"{customers["customer_id"].nunique(dropna =False)}")
print(
    f"missing customer ids:"
    f"{customers["customer_id"].duplicated().sum():,}"
)

#save
customers.to_csv(clean_folder/"customers.csv", index=False)
print()

#rows: 20,000
#columns: 7
##duplicate rows: 0
#misising values:
#customer_id         0
#name                0
#email               0
#country             0
#age                 0
#signup_date         0
#marketing_opt_in    0
#dtype: int64
#uniques customer_ids:20000
#missing customer ids:0
