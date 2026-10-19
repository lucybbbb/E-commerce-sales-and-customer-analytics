from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent 
data_folder = project_folder/"data"
clean_folder = data_folder/"clean"
orders = pd.read_csv(data_folder/"orders.csv")

#basic checks?
print(f"rows: {len(orders):,}")
print(f"duplicate rows: {orders.duplicated().sum():,}")
print(f"missing values:")
print(orders.isna().sum())

#check order_id 
print(f"unique order ids: {orders["order_id"].nunique(dropna=False):,}")
print(f"missing order ids: {orders["order_id"].isna().sum():,}")
print(
    f"duplicate order ids: "
    f"{orders["order_id"].duplicated().sum():,}"
)
#check order_time 
orders["order_time"] =pd.to_datetime(
    orders["order_time"], errors= "coerce"
)
print(f"invalid order_time values:"
      f"{orders["order_time"].isna().sum():,}")
print(f"earliest order: {orders["order_time"].min()}")
print(f"latst order: {orders["order_time"].max()}")

#check discount pct
print(f"minimum discount: {orders["discount_pct"].min():,}")
print(f"maximum discount: {orders["discount_pct"].max():,}")
invalid_discount = orders[
    (orders["discount_pct"] <0) |
    (orders["discount_pct"] <100)
]
print(f"invalid discount value: {len(invalid_discount):,}")

#validate total_usd
orders["calculated_total"] = (
    orders["subtotal_usd"] *(1-orders["discount_pct"]/100)
)
total_mismatches = orders[
    (
     orders["total_usd"] - orders["calculated_total"]
    ) .abs() >0.01
]
print(f"total mismatches: {len(total_mismatches):,}")

#remove temporary calculation column
orders = orders.drop(columns=["calculated_total"])
orders.to_csv(
    clean_folder/"orders.csv", index = False

)
print()

#rows: 33,580
#duplicate rows: 0
#missing values:
#order_id          0
#customer_id       0
#order_time        0
#payment_method    0
#discount_pct      0
#subtotal_usd      0
#total_usd         0
#country           0
#device            0
#source            0
#dtype: int64
#unique order ids: 33,580
#missing order ids: 0
#duplicate order ids: 0
#invalid order_time values:0
#earliest order: 2020-01-01 01:10:58
#latst order: 2025-10-31 22:59:41
#minimum discount: 0
#maximum discount: 20
#invalid discount value: 33,580
#total mismatches: 0