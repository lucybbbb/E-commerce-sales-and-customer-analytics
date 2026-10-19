from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder/"data"
clean_folder = data_folder/"clean"
sessions = pd.read_csv(data_folder/"sessions.csv")

#convert start_time to datetime 
sessions["start_time"] = pd.to_datetime(sessions["start_time"], errors ="coerce")
#check invalid dates 
invalid_dates = sessions["start_time"].isna().sum()
print(f"rows: {len(sessions):,}")
print(f"invalid start time: {invalid_dates:,}")

#save the cleaned data 
sessions.to_csv(clean_folder/"sessions.csv", index=False)
print()
print("clean session file saved")
