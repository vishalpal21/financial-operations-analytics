import pandas as pd
import mysql.connector
from sqlalchemy import create_engine
import warnings

warnings.filterwarnings('ignore')

print("=" * 70)
print("LOADING DATA TO MYSQL DATABASE")
print("=" * 70)

# Configuration
MYSQL_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'vishal',
    'database': 'financial_operations_db'
}

# Create database
print("\n[STEP 1] Creating Database...")
try:
    connection = mysql.connector.connect(
        host=MYSQL_CONFIG['host'],
        user=MYSQL_CONFIG['user'],
        password=MYSQL_CONFIG['password']
    )
    cursor = connection.cursor()
    cursor.execute(f"CREATE DATABASE IF NOT EXISTS {MYSQL_CONFIG['database']}")
    print("✓ Database created")
    cursor.close()
    connection.close()
except Exception as e:
    print(f"Error: {e}")

# Execute schema
print("\n[STEP 2] Creating Tables...")
try:
    connection = mysql.connector.connect(**MYSQL_CONFIG)
    cursor = connection.cursor()

    with open('database_schema.sql', 'r') as f:
        sql_script = f.read()
        # Execute each statement
        for statement in sql_script.split(';'):
            if statement.strip():
                cursor.execute(statement)

    connection.commit()
    print("✓ Tables and views created")
    cursor.close()
    connection.close()
except Exception as e:
    print(f"Error: {e}")

# Load data
print("\n[STEP 3] Loading Data...")
try:
    df = pd.read_csv("C:/Users/Vishal/Desktop/financial-operation-analytics/Data/enriched_financial_data.csv")
    df['Date'] = pd.to_datetime(df['Date'])

    engine = create_engine(
        f"mysql+pymysql://{MYSQL_CONFIG['user']}:{MYSQL_CONFIG['password']}@"
        f"{MYSQL_CONFIG['host']}/{MYSQL_CONFIG['database']}"
    )

    # Prepare data for fact_sales table
    fact_data = df[[
        'Segment', 'Country', 'Product', 'Discount_Band', 'Units_Sold',
        'Manufacturing_Price', 'Sale_Price', 'Gross_Sales', 'Discounts',
        'Sales', 'COGS', 'Profit', 'Date', 'Month_Number', 'Month_Name',
        'Year', 'Profit_Margin_Pct', 'Gross_Margin_Pct', 'Discount_Pct',
        'Unit_Profit', 'Contribution_Margin', 'Quarter', 'Fiscal_Year'
    ]].copy()

    fact_data.columns = [
        'segment', 'country', 'product', 'discount_band', 'units_sold',
        'manufacturing_price', 'sale_price', 'gross_sales', 'discounts',
        'sales', 'cogs', 'profit', 'transaction_date', 'month_number',
        'month_name', 'year', 'profit_margin_pct', 'gross_margin_pct',
        'discount_pct', 'unit_profit', 'contribution_margin', 'quarter',
        'fiscal_year'
    ]

    fact_data.to_sql('fact_sales', engine, if_exists='append', index=False, chunksize=1000)
    print(f"✓ Loaded {len(fact_data):,} records to fact_sales")

except Exception as e:
    print(f"Error: {e}")

# Verify
print("\n[STEP 4] Verification...")
try:
    connection = mysql.connector.connect(**MYSQL_CONFIG)
    cursor = connection.cursor()

    cursor.execute("SELECT COUNT(*) FROM fact_sales")
    count = cursor.fetchone()[0]
    print(f"✓ Total records in database: {count:,}")

    cursor.execute("SELECT MIN(transaction_date), MAX(transaction_date) FROM fact_sales")
    dates = cursor.fetchone()
    print(f"✓ Date range: {dates[0]} to {dates[1]}")

    cursor.close()
    connection.close()
except Exception as e:
    print(f"Error: {e}")

print("\n" + "=" * 70)
print("DATA LOADING COMPLETED!")
print("=" * 70)