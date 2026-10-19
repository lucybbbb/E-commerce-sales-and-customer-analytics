from pathlib import Path
print("current directory")
print(Path.cwd())
print()

data_folder = Path("E:\projects_data\eccomerce\data")
print("data folder path: ")
print(data_folder.resolve())
print()
print("Does the data folder exist?")
print(data_folder.exists())

#find the folder inside the project 
project_folder = Path(__file__).resolve().parent.parent

# Find the data folder inside the project
data_folder = project_folder / "data"

csv_files = list(data_folder.glob("*.csv"))

print("CSV files found:")
print("----------------")

for file in csv_files:
    print(file.name)

print()

print(f"Total CSV files: {len(csv_files)}")
