import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime
import warnings
warnings.filterwarnings('ignore')

print("="*70)
print("FINANCIAL OPERATIONS DATA - CLEANING & PREPARATION")
print("="*70)

# Load data
df = pd.read_excel("C:/Users/Vishal/Desktop/financial-operation-analytics/Data/Raw_Financials.xlsx")
print(f"\n✓ Loaded {len(df):,} records")
df.columns=df.columns.str.strip()

# Display basic info
print("\n[STEP 1] Data Overview:")
print(df.head())
print("\n", df.info())
print("\nBasic Statistics:")
print(df.describe())

# Check for missing values
print("\n[STEP 2] Missing Values:")
missing = df.isnull().sum()
print(missing[missing > 0])

# Data validation
print("\n[STEP 3] Data Validation:")
cols = ['Gross_Sales','Discounts', 'Sales', 'Profit', 'COGS']
for col in cols:
    df[col] = pd.to_numeric(df[col].replace('[\$,]','', regex=True),errors='coerce')


df['Calc_Gross_Sales'] = df['Units_Sold'] * df['Sale_Price']
df['Calc_Sales'] = df['Gross_Sales'] - df['Discounts']
df['Calc_Profit'] = df['Sales'] - df['COGS']

# Check for discrepancies
discrepancies = df[
    (abs(df['Gross_Sales'] - df['Calc_Gross_Sales']) > 0.01) |
    (abs(df['Sales'] - df['Calc_Sales']) > 0.01) |
    (abs(df['Profit'] - df['Calc_Profit']) > 0.01)
]

if len(discrepancies) > 0:
    print(f"⚠️ Found {len(discrepancies)} calculation discrepancies")
    print("Correcting calculations...")
    df['Gross_Sales'] = df['Calc_Gross_Sales']
    df['Sales'] = df['Calc_Sales']
    df['Profit'] = df['Calc_Profit']
else:
    print("✓ All calculations validated")

# Drop temporary columns
df = df.drop(['Calc_Gross_Sales', 'Calc_Sales', 'Calc_Profit'], axis=1)

# Clean data
print("\n[STEP 4] Data Cleaning:")

# Remove duplicates
duplicates = df.duplicated().sum()
if duplicates > 0:
    df = df.drop_duplicates()
    print(f"✓ Removed {duplicates} duplicates")

# Handle missing values
df = df.dropna(subset=['Date', 'Sales', 'Profit'])
df['Discount_Band'] = df['Discount_Band'].fillna('None')

# Standardize text columns
text_cols = ['Segment', 'Country', 'Product', 'Discount_Band', 'Month_Name']
for col in text_cols:
    df[col] = df[col].str.strip().str.title()

# Convert date
df['Date'] = pd.to_datetime(df['Date'])

# Ensure correct data types
df['Units_Sold'] = df['Units_Sold'].astype(int)
df['Month_Number'] = df['Month_Number'].astype(int)
df['Year'] = df['Year'].astype(int)

numeric_cols = ['Manufacturing_Price', 'Sale_Price', 'Gross_Sales',
                'Discounts', 'Sales', 'COGS', 'Profit']
for col in numeric_cols:
    df[col] = pd.to_numeric(df[col], errors='coerce')

print("✓ Data cleaned successfully")
print(f"Final dataset: {len(df):,} rows")

# Save cleaned data
df.to_csv('cleaned_financial_data.csv', index=False)
print("\n✓ Saved: cleaned_financial_data.csv")