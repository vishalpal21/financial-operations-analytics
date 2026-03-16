import pandas as pd
import numpy as np

print("\n[STEP 5] Feature Engineering:")

df = pd.read_csv("C:/Users/Vishal/Desktop/financial-operation-analytics/Data/cleaned_financial_data.csv")
df['Date'] = pd.to_datetime(df['Date'])

# 1. Financial Metrics
print("\nCreating financial metrics...")

# Profit Margin %
df['Profit_Margin_Pct'] = (df['Profit'] / df['Sales'] * 100).round(2)

# Gross Margin %
df['Gross_Margin_Pct'] = ((df['Sales'] - df['COGS']) / df['Sales'] * 100).round(2)

# Discount Percentage
df['Discount_Pct'] = (df['Discounts'] / df['Gross_Sales'] * 100).round(2)

# Unit Profit
df['Unit_Profit'] = (df['Profit'] / df['Units_Sold']).round(2)

# Unit Cost
df['Unit_Cost'] = (df['COGS'] / df['Units_Sold']).round(2)

# Markup %
df['Markup_Pct'] = ((df['Sale_Price'] - df['Manufacturing_Price']) /
                     df['Manufacturing_Price'] * 100).round(2)

# Contribution Margin
df['Contribution_Margin'] = df['Sales'] - df['COGS']
df['Contribution_Margin_Pct'] = (df['Contribution_Margin'] / df['Sales'] * 100).round(2)

# 2. Time-based Features
print("Creating time features...")

df['Quarter'] = df['Date'].dt.quarter
df['Week'] = df['Date'].dt.isocalendar().week
df['Day_of_Week'] = df['Date'].dt.day_name()
df['Is_Weekend'] = df['Date'].dt.dayofweek.isin([5, 6]).astype(int)

# Fiscal Year (assuming April start)
df['Fiscal_Year'] = df.apply(
    lambda x: x['Year'] if x['Month_Number'] < 4 else x['Year'] + 1, axis=1
)

# Year-Month for sorting
df['Year_Month'] = df['Date'].dt.to_period('M').astype(str)

# 3. Categorizations
print("Creating categories...")

# Revenue Size Categories
df['Revenue_Category'] = pd.cut(
    df['Sales'],
    bins=[0, 10000, 50000, 100000, float('inf')],
    labels=['Small', 'Medium', 'Large', 'Enterprise']
)

# Profit Categories
df['Profit_Category'] = pd.cut(
    df['Profit'],
    bins=[float('-inf'), 0, 5000, 20000, float('inf')],
    labels=['Loss', 'Low Profit', 'Medium Profit', 'High Profit']
)

# Discount Tier (standardize)
discount_mapping = {
    'None': 'No Discount',
    'Low': 'Low Discount',
    'Medium': 'Medium Discount',
    'High': 'High Discount'
}
df['Discount_Tier'] = df['Discount_Band'].map(discount_mapping)

# 4. Business Metrics
print("Creating business metrics...")

# Sales per Unit
df['Sales_Per_Unit'] = (df['Sales'] / df['Units_Sold']).round(2)

# COGS per Unit
df['COGS_Per_Unit'] = (df['COGS'] / df['Units_Sold']).round(2)

# Discount per Unit
df['Discount_Per_Unit'] = (df['Discounts'] / df['Units_Sold']).round(2)

# 5. Performance Indicators
print("Creating performance flags...")

# High Margin Flag
df['Is_High_Margin'] = (df['Profit_Margin_Pct'] > 30).astype(int)

# Loss Maker Flag
df['Is_Loss'] = (df['Profit'] < 0).astype(int)

# High Discount Flag
df['Is_Heavy_Discount'] = (df['Discount_Pct'] > 20).astype(int)

print(f"\n✓ Created {len(df.columns)} total features")
print("\nNew Features Added:")
print(df.columns.tolist())

# Save enriched data
df.to_csv('enriched_financial_data.csv', index=False)
print("\n✓ Saved: enriched_financial_data.csv")

# Display sample
print("\nSample of enriched data:")
print(df[['Product', 'Sales', 'Profit', 'Profit_Margin_Pct',
          'Gross_Margin_Pct', 'Discount_Pct']].head())