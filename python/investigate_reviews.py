from pathlib import Path
import pandas as pd


project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder / "data"
reviews = pd.read_csv(data_folder / "reviews.csv")
print("REVIEWS INVESTIGATION")

# 1. Check rating values
print()
print("RATING VALUES")
print(reviews["rating"].value_counts().sort_index())

# 2. Check review text values

print("UNIQUE REVIEW TEXTS")


print(f"Unique review texts: {reviews['review_text'].nunique()}")

print()

for text in reviews["review_text"].drop_duplicates():
    print("-", text)

# 3. Check review date/time
print()
print("REVIEW TIME")
review_dates = pd.to_datetime(
    reviews["review_time"],
    errors="coerce"
)

print(f"Invalid dates: {review_dates.isna().sum():,}")
print(f"Earliest review: {review_dates.min()}")
print(f"Latest review: {review_dates.max()}")
#UNIQUE REVIEW TEXTS
#Unique review texts: 5

#- Not great quality.
#- Good value for money!
#- Excellent product, highly recommend!
#- Okay overall.
#- Very disappointed, would not buy again.
# Invalid dates: 0
#Earliest review: 2020-01-01 00:00:00
#Latest review: 2025-11-01 00:00
#inspect the review texts
#get the review texts: 
review_text = reviews["review_text"].drop_duplicates()
for text in review_text: 
    print(
        reviews.groupby(["rating", "review_text"]).size())

# evey review has one of the predefined texts, and the text correponds exactly to is rating 
#rating  review_text                            
#1       Very disappointed, would not buy again.     423
#2       Not great quality.                          757
#3       Okay overall.                              1980
#4       Good value for money!                      3565
#5       Excellent product, highly recommend!       4055
#10780 rows in total
#0 duplicates 
#review_id unique
#0 missing values
#rating has valid-looking 1-5 categories 
#review_text has 5 predefined templates mapped exactly to rating 
#revie_time has 0 invalid dates 
