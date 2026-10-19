from pathlib import Path
import pandas as pd
project_folder = Path(__file__).resolve().parent.parent
data_folder = project_folder / "data"

csv_files = list(data_folder.glob("*.csv"))

# 2. Load all tables
tables = {}

for file in csv_files:
    table_name = file.stem
    tables[table_name] = pd.read_csv(file)
# 3. Find shared ID columns
column_locations = {}

for table_name, table in tables.items():
    for column in table.columns:
        # Only consider columns that look like IDs
        if "id" in column.lower():
            if column not in column_locations:
                column_locations[column] = []
            column_locations[column].append(table_name)

# 4. Validate each shared ID column
for column, table_names in column_locations.items():
    # We only care about columns found in multiple tables
    if len(table_names) < 2:
        continue
    print()
    print("=" * 70)
    print(f"RELATIONSHIP COLUMN: {column}")
    print("=" * 70)
    # Compare every pair of tables
    for i in range(len(table_names)):

        for j in range(i + 1, len(table_names)):

            table_a_name = table_names[i]
            table_b_name = table_names[j]

            table_a = tables[table_a_name]
            table_b = tables[table_b_name]

            # Get unique, non-missing IDs
            ids_a = set(table_a[column].dropna())
            ids_b = set(table_b[column].dropna())

            # Find IDs appearing in B but not A
            orphan_b = ids_b - ids_a

            # Find IDs appearing in A but not B
            orphan_a = ids_a - ids_b

            # Count how many times each ID appears
            counts_a = table_a[column].value_counts()
            counts_b = table_b[column].value_counts()

            print()
            print(f"{table_a_name} ↔ {table_b_name}")

            print(f"Unique IDs in {table_a_name}: {len(ids_a):,}")
            print(f"Unique IDs in {table_b_name}: {len(ids_b):,}")

            print(
                f"IDs in {table_b_name} but not {table_a_name}: "
                f"{len(orphan_b):,}"
            )

            print(
                f"IDs in {table_a_name} but not {table_b_name}: "
                f"{len(orphan_a):,}"
            )

            print(
                f"Maximum occurrences of one ID in {table_a_name}: "
                f"{counts_a.max()}"
            )

            print(
                f"Maximum occurrences of one ID in {table_b_name}: "
                f"{counts_b.max()}"
            )