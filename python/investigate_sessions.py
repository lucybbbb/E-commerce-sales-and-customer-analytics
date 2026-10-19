from pathlib import Path
import pandas as pd

project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder / "data"

# Read sessions
sessions = pd.read_csv(data_folder / "sessions.csv")


print("SESSIONS INVESTIGATION")

# 1. Check session start times

print("START TIME")

session_dates = pd.to_datetime(
    sessions["start_time"],
    errors="coerce"
)

print(f"Invalid dates: {session_dates.isna().sum():,}")
print(f"Earliest session: {session_dates.min()}")
print(f"Latest session: {session_dates.max()}")
# 2. Check device values
print(sessions["device"].value_counts())

# 3. Check traffic sources
print(sessions["source"].value_counts())

# 4. Check countries

print()
print(sessions["country"].value_counts())