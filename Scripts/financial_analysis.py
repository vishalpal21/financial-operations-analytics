import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os

sns.set_style("whitegrid")
os.makedirs('financial_analysis', exist_ok=True)

print("="*70)
print("FINANCIAL OPERATIONS ANALYSIS")
print("="*70)

# Load data
df = pd.read_csv("C:/Users/Vishal/Desktop/financial-operation-analytics/Data/enriched_financial_data.csv")
df['Date'] = pd.to_datetime(df['Date'])

# ============================================================================
# ANALYSIS 1: PROFIT & LOSS STATEMENT
# ============================================================================
print("\n[ANALYSIS 1] Profit & Loss Summary")
print("-" * 70)

pl_summary = {
    'Gross Sales': df['Gross_Sales'].sum(),
    'Less: Discounts': df['Discounts'].sum(),
    'Net Sales': df['Sales'].sum(),
    'Cost of Goods Sold (COGS)': df['COGS'].sum(),
    'Gross Profit': df['Sales'].sum() - df['COGS'].sum(),
    'Net Profit': df['Profit'].sum()
}

pl_df = pd.DataFrame(list(pl_summary.items()), columns=['Item', 'Amount'])
pl_df['Amount'] = pl_df['Amount'].apply(lambda x: f"${x:,.2f}")

print("\nProfit & Loss Statement:")
print(pl_df.to_string(index=False))

# Calculate key ratios
gross_margin = (pl_summary['Gross Profit'] / pl_summary['Net Sales']) * 100
net_margin = (pl_summary['Net Profit'] / pl_summary['Net Sales']) * 100
discount_rate = (pl_summary['Less: Discounts'] / pl_summary['Gross Sales']) * 100

print(f"\nKey Ratios:")
print(f"  Gross Margin: {gross_margin:.2f}%")
print(f"  Net Profit Margin: {net_margin:.2f}%")
print(f"  Average Discount Rate: {discount_rate:.2f}%")

# ============================================================================
# ANALYSIS 2: SEGMENT PROFITABILITY
# ============================================================================
print("\n[ANALYSIS 2] Segment Profitability Analysis")
print("-" * 70)

segment_analysis = df.groupby('Segment').agg({
    'Sales': 'sum',
    'Profit': 'sum',
    'COGS': 'sum',
    'Units_Sold': 'sum',
    'Profit_Margin_Pct': 'mean'
}).round(2)

segment_analysis['Contribution_Pct'] = (
    segment_analysis['Profit'] / segment_analysis['Profit'].sum() * 100
).round(2)

segment_analysis = segment_analysis.sort_values('Profit', ascending=False)

print("\nSegment Performance:")
print(segment_analysis)

# Visualize
fig, axes = plt.subplots(1, 2, figsize=(16, 6))
fig.suptitle('Segment Profitability Analysis', fontsize=16, fontweight='bold')

# Profit by segment
segment_analysis['Profit'].plot(kind='bar', ax=axes[0], color='steelblue')
axes[0].set_title('Total Profit by Segment')
axes[0].set_xlabel('Segment')
axes[0].set_ylabel('Profit ($)')
axes[0].tick_params(axis='x', rotation=45)

# Profit margin by segment
segment_analysis['Profit_Margin_Pct'].plot(kind='bar', ax=axes[1], color='coral')
axes[1].set_title('Average Profit Margin by Segment')
axes[1].set_xlabel('Segment')
axes[1].set_ylabel('Profit Margin (%)')
axes[1].tick_params(axis='x', rotation=45)
axes[1].axhline(y=net_margin, color='red', linestyle='--', label='Overall Avg')
axes[1].legend()

plt.tight_layout()
plt.savefig('financial_analysis/01_segment_profitability.png', dpi=300, bbox_inches='tight')
print("✓ Saved: 01_segment_profitability.png")
plt.close()

# ============================================================================
# ANALYSIS 3: PRODUCT PROFITABILITY
# ============================================================================
print("\n[ANALYSIS 3] Product Performance Analysis")
print("-" * 70)

product_analysis = df.groupby('Product').agg({
    'Sales': 'sum',
    'Profit': 'sum',
    'Units_Sold': 'sum',
    'Profit_Margin_Pct': 'mean'
}).round(2)

product_analysis = product_analysis.sort_values('Profit', ascending=False)

print("\nTop 10 Products by Profit:")
print(product_analysis.head(10))

# Product profitability matrix
fig, ax = plt.subplots(figsize=(12, 8))
scatter = ax.scatter(
    product_analysis['Sales'],
    product_analysis['Profit_Margin_Pct'],
    s=product_analysis['Units_Sold']/10,
    c=product_analysis['Profit'],
    cmap='RdYlGn',
    alpha=0.6,
    edgecolors='black'
)

ax.set_xlabel('Total Sales ($)', fontsize=12)
ax.set_ylabel('Profit Margin (%)', fontsize=12)
ax.set_title('Product Profitability Matrix\n(Size = Units Sold, Color = Profit)',
             fontsize=14, fontweight='bold')
ax.axhline(y=net_margin, color='red', linestyle='--', alpha=0.7, label='Avg Margin')
ax.grid(alpha=0.3)
ax.legend()

plt.colorbar(scatter, label='Profit ($)')
plt.tight_layout()
plt.savefig('financial_analysis/02_product_profitability.png', dpi=300, bbox_inches='tight')
print("✓ Saved: 02_product_profitability.png")
plt.close()

# ============================================================================
# ANALYSIS 4: DISCOUNT IMPACT ANALYSIS
# ============================================================================
print("\n[ANALYSIS 4] Discount Effectiveness Analysis")
print("-" * 70)

discount_analysis = df.groupby('Discount_Band').agg({
    'Sales': 'sum',
    'Profit': 'sum',
    'Units_Sold': 'sum',
    'Discount_Pct': 'mean',
    'Profit_Margin_Pct': 'mean'
}).round(2)

print("\nDiscount Band Performance:")
print(discount_analysis)

# Visualize discount impact
fig, axes = plt.subplots(2, 2, figsize=(16, 12))
fig.suptitle('Discount Impact Analysis', fontsize=16, fontweight='bold')

# Sales by discount band
discount_analysis['Sales'].plot(kind='bar', ax=axes[0, 0], color='skyblue')
axes[0, 0].set_title('Sales by Discount Band')
axes[0, 0].set_ylabel('Sales ($)')
axes[0, 0].tick_params(axis='x', rotation=45)

# Profit by discount band
discount_analysis['Profit'].plot(kind='bar', ax=axes[0, 1], color='lightgreen')
axes[0, 1].set_title('Profit by Discount Band')
axes[0, 1].set_ylabel('Profit ($)')
axes[0, 1].tick_params(axis='x', rotation=45)

# Profit margin trend
axes[1, 0].plot(discount_analysis.index, discount_analysis['Profit_Margin_Pct'],
                marker='o', linewidth=2, markersize=8, color='coral')
axes[1, 0].set_title('Profit Margin by Discount Level')
axes[1, 0].set_xlabel('Discount Band')
axes[1, 0].set_ylabel('Profit Margin (%)')
axes[1, 0].grid(alpha=0.3)
axes[1, 0].tick_params(axis='x', rotation=45)

# Units sold vs discount
axes[1, 1].bar(discount_analysis.index, discount_analysis['Units_Sold'],
               color='purple', alpha=0.7)
axes[1, 1].set_title('Volume Sold by Discount Band')
axes[1, 1].set_xlabel('Discount Band')
axes[1, 1].set_ylabel('Units Sold')
axes[1, 1].tick_params(axis='x', rotation=45)

plt.tight_layout()
plt.savefig('financial_analysis/03_discount_analysis.png', dpi=300, bbox_inches='tight')
print("✓ Saved: 03_discount_analysis.png")
plt.close()

# ============================================================================
# ANALYSIS 5: MONTHLY TRENDS
# ============================================================================
print("\n[ANALYSIS 5] Monthly Performance Trends")
print("-" * 70)

monthly_trend = df.groupby(['Year', 'Month_Number', 'Month_Name']).agg({
    'Sales': 'sum',
    'Profit': 'sum',
    'Units_Sold': 'sum',
    'Profit_Margin_Pct': 'mean'
}).reset_index()

monthly_trend['Year_Month'] = monthly_trend['Year'].astype(str) + '-' + monthly_trend['Month_Number'].astype(str).str.zfill(2)

print("\nMonthly Trends (Last 12 Months):")
print(monthly_trend.tail(12)[['Year_Month', 'Sales', 'Profit', 'Profit_Margin_Pct']])

# Visualize trends
fig, axes = plt.subplots(2, 1, figsize=(16, 10))
fig.suptitle('Monthly Financial Performance Trends', fontsize=16, fontweight='bold')

# Sales and Profit trend
ax1 = axes[0]
ax1.plot(monthly_trend.index, monthly_trend['Sales'], marker='o', linewidth=2,
         label='Sales', color='blue')
ax1.set_ylabel('Sales ($)', color='blue', fontsize=12)
ax1.tick_params(axis='y', labelcolor='blue')
ax1.grid(alpha=0.3)

ax2 = ax1.twinx()
ax2.plot(monthly_trend.index, monthly_trend['Profit'], marker='s', linewidth=2,
         label='Profit', color='green')
ax2.set_ylabel('Profit ($)', color='green', fontsize=12)
ax2.tick_params(axis='y', labelcolor='green')

ax1.set_title('Monthly Sales & Profit Trend')
ax1.legend(loc='upper left')
ax2.legend(loc='upper right')

# Profit margin trend
axes[1].plot(monthly_trend.index, monthly_trend['Profit_Margin_Pct'],
             marker='o', linewidth=2, color='coral')
axes[1].axhline(y=net_margin, color='red', linestyle='--', label='Average')
axes[1].set_ylabel('Profit Margin (%)', fontsize=12)
axes[1].set_xlabel('Month', fontsize=12)
axes[1].set_title('Monthly Profit Margin Trend')
axes[1].grid(alpha=0.3)
axes[1].legend()

plt.tight_layout()
plt.savefig('financial_analysis/04_monthly_trends.png', dpi=300, bbox_inches='tight')
print("✓ Saved: 04_monthly_trends.png")
plt.close()

# Save analysis summary
summary_report = f"""
FINANCIAL OPERATIONS ANALYSIS SUMMARY
{"="*70}

OVERALL PERFORMANCE:
- Total Net Sales: ${pl_summary['Net Sales']:,.2f}
- Total Profit: ${pl_summary['Net Profit']:,.2f}
- Net Profit Margin: {net_margin:.2f}%
- Total Units Sold: {df['Units_Sold'].sum():,}

TOP PERFORMING SEGMENT:
- {segment_analysis.index[0]}: ${segment_analysis['Profit'].iloc[0]:,.2f} profit

TOP PERFORMING PRODUCT:
- {product_analysis.index[0]}: ${product_analysis['Profit'].iloc[0]:,.2f} profit

DISCOUNT EFFECTIVENESS:
- Average Discount Rate: {discount_rate:.2f}%
- Best Performing Discount Band: {discount_analysis['Profit'].idxmax()}

RECOMMENDATIONS:
1. Focus on high-margin segments and products
2. Optimize discount strategy to maintain profitability
3. Investigate loss-making products/segments
4. Monitor monthly trends for seasonal patterns
"""

with open('financial_analysis/analysis_summary.txt', 'w') as f:
    f.write(summary_report)

print("\n" + "="*70)
print("FINANCIAL ANALYSIS COMPLETED!")
print("="*70)
print("\nGenerated Files:")
print("  1. 01_segment_profitability.png")
print("  2. 02_product_profitability.png")
print("  3. 03_discount_analysis.png")
print("  4. 04_monthly_trends.png")
print("  5. analysis_summary.txt")