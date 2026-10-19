import sys, os, pyodbc, yaml, pandas as pd

# 1. Load credentials directly from ~/.dbt/profiles.yml
profile_path = os.path.expanduser("~/.dbt/profiles.yml")
with open(profile_path, "r") as f:
    profiles = yaml.safe_load(f)
    creds = profiles.get("fabric_project", profiles.get("my_reports", {})).get("outputs", {}).get("dev", {})

conn_str = (
    f"DRIVER={{{creds.get('driver', 'ODBC Driver 18 for SQL Server')}}};SERVER={creds.get('server', '')};"
    f"DATABASE={creds.get('database', '')};UID={creds.get('user', '')};PWD={creds.get('password', '')};"
    f"Encrypt=yes;TrustServerCertificate=yes;"
)

# 2. Dynamically locate the compiled SQL file regardless of folder depth
model_name = sys.argv[1].replace(".sql", "")
compiled_file = None

for root, _, files in os.walk("target/compiled"):
    if f"{model_name}.sql" in files:
        compiled_file = os.path.join(root, f"{model_name}.sql")
        break

if not compiled_file:
    raise FileNotFoundError(f"Compiled SQL for '{model_name}' not found. Did you run 'dbt compile'?")

with open(compiled_file, "r") as f:
    query = f.read()

# 3. Execute query and export to CSV
print(f"Executing '{model_name}' against warehouse...")
with pyodbc.connect(conn_str) as conn:
    df = pd.read_sql(query, conn)

os.makedirs("exports", exist_ok=True)
output_path = f"exports/{model_name}.csv"
df.to_csv(output_path, index=False)
print(f"? Success! Exported {len(df)} rows to {output_path}")
