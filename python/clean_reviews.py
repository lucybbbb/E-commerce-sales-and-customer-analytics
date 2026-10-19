from pathlib import Path
import pandas as pd 
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder/"data"
clean_folder = data_folder/"clean"
reviews = pd.read_csv(data_folder/"reviews.csv")

#convert review_time in datetime 
reviews["date_time"] = pd.to_datetime(reviews["review_time"], errors ="coerce")

#validate the conversion
invalid_dates = reviews["review_time"].isna().sum()
print(f"rows: {len(reviews):,}")
print(f"invalid review_time reviews: {invalid_dates:,}")
print(f"duplicate rows: {reviews.duplicated().sum()}")
print(f"duplicate reviews ids: {reviews["review_id"].duplicated().sum():,}")

#save
reviews.to_csv(
    clean_folder/"reviews.csv", index = False
)
print()
#rows: 10,780
#invalid review_time reviews: 0
#duplicate rows: 0
#duplicate reviews ids: 0

