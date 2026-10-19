from pathlib import Path
import pandas as pd 

project_folder = Path(__file__).resolve().parent.parent 
data_folder = project_folder/"data"

order_items = pd.read_csv(data_folder/ "order_items.csv")

#find the duplicates 
duplicates = order_items[order_items.duplicated(keep =False)]
print("=" * 70)
print("order_items duplicates: ")
print("=" *70)
print(f"Total rows: {len(order_items):,}")
print(f"Duplicate rows: {order_items.duplicated().sum():,}")
print()
print("Duplicate records: ")
print(duplicates.sort_values(
    by=["order_id", "product_id"])
.to_string(index=False))
# Remove exact duplicates
clean_test = order_items.drop_duplicates()

# Check whether order_id + product_id is repeated
repeated_pairs = clean_test[
    clean_test.duplicated(
        subset=["order_id", "product_id"],
        keep=False
    )
]

print()
print("Repeated order_id + product_id combinations after removing exact duplicates:")
print(len(repeated_pairs))

if len(repeated_pairs) > 0:
    print(repeated_pairs.sort_values(
        ["order_id", "product_id"]
    ).to_string(index=False))

print()
print("Repeated order_id + product_id combinations:")

print(
    repeated_pairs.sort_values(
        ["order_id", "product_id"]
    ).to_string(index=False)
)   

# check if line_total_usd = unit_price_usd * qty ???

order_items["calculated_total"] = (order_items["unit_price_usd"] * order_items["quantity"])
mismatches = order_items[(order_items["line_total_usd"] - order_items["calculated_total"]).abs() 
                         >0.01

                                                 ]
print()
print("line total validation:")
print()

print(f"rows checked: {len(order_items):,}")
print(f"mismatches: {len(mismatches):,}")

if len(mismatches) >0:
    print()
    print(mismatches[
       [ "order_id",
        "product_id",
        "unit_price_usd",
        "quantity",
        "line_total_usd",
        "calculated_total"
    ]
    ].to_string(index=False))


                                                 
