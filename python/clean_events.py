from pathlib import Path
import pandas as pd 
project_foler = Path(__file__).resolve().parent.parent
data_folder = project_foler/"data"
clean_folder = data_folder/"clean"
events = pd.read_csv(data_folder/"events.csv")

#check original nr of rows
original_rows = len(events)
print(f"original rows: {original_rows:,}")

#convert timestamp into datetime 
events["timestamp"] =pd.to_datetime(events["timestamp"], errors = "coerce")

#check wheter any timestamp become invalid 
invalid_timestamps = events["timestamp"].isna().sum()

print(f"invalid timestamps after conversion: {invalid_timestamps:,}")

#check if event_id is still unique
duplicate_event_ids = events["event_id"].duplicated().sum()
print(f"duplicated event ids: {duplicate_event_ids:,}")

#save the cleaned table
events.to_csv(clean_folder/"events.csv", index=False)
print()

#original rows: 760,958
#invalid timestamps after conversion: 0
#duplicated event ids: 0
#product_id, qty, cart_size - float64 type, will be analysed in sql and decided the appropriate sql type

            