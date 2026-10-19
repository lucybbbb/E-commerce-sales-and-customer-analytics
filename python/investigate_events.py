from pathlib import Path
import pandas as pd

project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder / "data"

# Read events
events = pd.read_csv(data_folder / "events.csv")

print("EVENTS INVESTIGATION")

# 1. Check event types

print(events["event_type"].value_counts())

# 2. Check missing values by event type

missing_by_event = events.groupby("event_type").agg(
    product_id_missing=("product_id", lambda x: x.isna().sum()),
    qty_missing=("qty", lambda x: x.isna().sum()),
    cart_size_missing=("cart_size", lambda x: x.isna().sum()),
    payment_missing=("payment", lambda x: x.isna().sum()),
    discount_missing=("discount_pct", lambda x: x.isna().sum()),
    amount_missing=("amount_usd", lambda x: x.isna().sum())
)

print(missing_by_event)

# 3. Check event timestamps

event_dates = pd.to_datetime(
    events["timestamp"],
    errors="coerce"
)

print(f"Invalid timestamps: {event_dates.isna().sum():,}")
print(f"Earliest event: {event_dates.min()}")
print(f"Latest event: {event_dates.max()}")