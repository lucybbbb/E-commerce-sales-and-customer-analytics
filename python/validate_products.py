from pathlib import Path
import pandas as pd

project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder/"data"

#read products
products = pd.read_csv(data_folder /"products.csv")
#calculate the margin?
products["calculated_margin"] = (products["price_usd"] - products["cost_usd"])

#find rows where the stored margin differes from the calculated margin 
mismatches = products[
    (products["margin_usd"] - products["calculated_margin"]).abs()>0.01
]
print()
print("margin validation:")
print()

print()
print(f"rows checked: {len(products):,}")
print(f"mismatches: {len(mismatches):,}")

if len(mismatches) >0:
    print()
    print("mismatched rows: ")
    print(
        mismatches[
            [
                "product_id", 
                "price_usd",
                "cost_usd",
                "margin_usd",
                "calculated_margin"
            ]
        ].to_string(index=False)
    )
    #rows checked: 1197
    #mismatches: 0
    #margin_usd consistent throughout the table 

    #check the negative or zero margins
    # Check for negative margins
negative_margin = products[products["margin_usd"] < 0]

# Check for zero margins
zero_margin = products[products["margin_usd"] == 0]

print()
print("MARGIN CHECK")


print()
print(f"Products with negative margin: {len(negative_margin):,}")
print(f"Products with zero margin: {len(zero_margin):,}")

if len(negative_margin) > 0:
    print()
    print("Products with negative margin:")
    print(
        negative_margin[
            [
                "product_id",
                "name",
                "price_usd",
                "cost_usd",
                "margin_usd"
            ]
        ].to_string(index=False)
    )
    # products with negative margin:0
    #products with zero margin:0
    