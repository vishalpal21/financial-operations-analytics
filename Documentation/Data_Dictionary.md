\# Financial Operations Analytics - Data Dictionary

\## Document Information

\*\*Project:\*\* Financial Operations Performance Analytics
\*\*Version:\*\* 1.0 \*\*Last Updated:\*\* March 2026 \*\*Database:\*\*
financial_operations_db \*\*Primary Table:\*\* fact_sales

\-\--

\## Table of Contents 1. \[Database Overview\](#database-overview) 2.
\[Fact Tables\](#fact-tables) 3. \[Dimension Tables\](#dimension-tables)
4. \[Calculated Fields\](#calculated-fields) 5. \[Database
Views\](#database-views) 6. \[DAX Measures\](#dax-measures) 7. \[Data
Quality Rules\](#data-quality-rules) 8. \[Glossary\](#glossary)

\-\--

\## 1. Database Overview

\### Database Structure - \*\*Database Name:\*\*
\`financial_operations_db\` - \*\*DBMS:\*\* MySQL 8.0 - \*\*Character
Set:\*\* UTF8MB4 - \*\*Total Tables:\*\* 1 fact table + 4 views -
\*\*Total Records:\*\* \~15,000 transactions - \*\*Data Period:\*\*
January 2024 - December 2026

\### Entity Relationship \`\`\` Date_Dimension (1) ──────── (\*)
fact_sales \`\`\`

\-\--

\## 2. Fact Tables

\### 2.1 fact_sales

\*\*Description:\*\* Central transaction table containing all financial
and operational data

\*\*Table Details:\*\* - \*\*Primary Key:\*\* transaction_id - \*\*Row
Count:\*\* 15,234 (as of last refresh) - \*\*Indexes:\*\*
transaction_date, segment, country, product - \*\*Update Frequency:\*\*
Monthly

\#### Column Specifications

\| Column Name \| Data Type \| Length \| Nullable \| Default \|
Description \| Example \|
\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\--\|
\| \*\*transaction_id\*\* \| INT \| - \| NO \| AUTO_INCREMENT \| Unique
identifier for each transaction \| 1, 2, 3\... \| \| \*\*segment\*\* \|
VARCHAR \| 50 \| NO \| - \| Business segment classification \|
\"Government\", \"Enterprise\" \| \| \*\*country\*\* \| VARCHAR \| 50 \|
NO \| - \| Country where sale occurred \| \"United States\", \"Canada\"
\| \| \*\*product\*\* \| VARCHAR \| 100 \| NO \| - \| Product
name/category \| \"Paseo\", \"VTT\", \"Montana\" \| \|
\*\*discount_band\*\* \| VARCHAR \| 50 \| YES \| \'None\' \| Discount
tier applied \| \"None\", \"Low\", \"Medium\", \"High\" \| \|
\*\*units_sold\*\* \| INT \| - \| NO \| - \| Quantity of units sold \|
100, 250, 500 \| \| \*\*manufacturing_price\*\* \| DECIMAL \| (12,2) \|
NO \| - \| Cost to produce one unit \| 45.50, 62.00 \| \|
\*\*sale_price\*\* \| DECIMAL \| (12,2) \| NO \| - \| Selling price per
unit \| 125.00, 89.99 \| \| \*\*gross_sales\*\* \| DECIMAL \| (15,2) \|
NO \| - \| Revenue before discounts (Units × Sale_Price) \| 12500.00 \|
\| \*\*discounts\*\* \| DECIMAL \| (15,2) \| YES \| 0.00 \| Total
discount amount \| 850.00 \| \| \*\*sales\*\* \| DECIMAL \| (15,2) \| NO
\| - \| Net revenue (Gross_Sales - Discounts) \| 11650.00 \| \|
\*\*cogs\*\* \| DECIMAL \| (15,2) \| NO \| - \| Cost of Goods Sold \|
4550.00 \| \| \*\*profit\*\* \| DECIMAL \| (15,2) \| NO \| - \| Net
profit (Sales - COGS) \| 7100.00 \| \| \*\*transaction_date\*\* \| DATE
\| - \| NO \| - \| Date of transaction \| 2024-03-15 \| \|
\*\*month_number\*\* \| INT \| - \| NO \| - \| Month (1-12) \| 3 \| \|
\*\*month_name\*\* \| VARCHAR \| 20 \| NO \| - \| Month name \|
\"March\" \| \| \*\*year\*\* \| INT \| - \| NO \| - \| Calendar year \|
2024 \| \| \*\*profit_margin_pct\*\* \| DECIMAL \| (10,2) \| YES \| - \|
(Profit / Sales) × 100 \| 26.50 \| \| \*\*gross_margin_pct\*\* \|
DECIMAL \| (10,2) \| YES \| - \| ((Sales - COGS) / Sales) × 100 \| 26.50
\| \| \*\*discount_pct\*\* \| DECIMAL \| (10,2) \| YES \| - \|
(Discounts / Gross_Sales) × 100 \| 6.80 \| \| \*\*unit_profit\*\* \|
DECIMAL \| (10,2) \| YES \| - \| Profit / Units_Sold \| 71.00 \| \|
\*\*contribution_margin\*\* \| DECIMAL \| (15,2) \| YES \| - \| Sales -
COGS \| 7100.00 \| \| \*\*contribution_margin_pct\*\* \| DECIMAL \|
(10,2) \| YES \| - \| (Contribution_Margin / Sales) × 100 \| 26.50 \| \|
\*\*quarter\*\* \| INT \| - \| YES \| - \| Quarter (1-4) \| 1 \| \|
\*\*fiscal_year\*\* \| INT \| - \| YES \| - \| Fiscal year (April-March)
\| 2025 \|

\#### Business Rules

\*\*Financial Calculations:\*\* \`\`\`sql gross_sales = units_sold ×
sale_price sales = gross_sales - discounts profit = sales - cogs
profit_margin_pct = (profit / sales) × 100 \`\`\`

\*\*Data Constraints:\*\* - \`units_sold\` \> 0 - \`sales\` ≥ 0 -
\`manufacturing_price\` ≤ \`sale_price\` (in 95%+ cases) - \`discounts\`
≤ \`gross_sales\` - \`cogs\` ≤ \`sales\` (in normal cases) -
\`transaction_date\` BETWEEN \'2024-01-01\' AND \'2026-12-31\'

\-\--

\## 3. Dimension Tables

\### 3.1 Date_Dimension

\*\*Description:\*\* Calendar dimension for time-based analysis

\*\*Created Using:\*\* DAX in Power BI

\| Column Name \| Data Type \| Description \| Example \|
\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\--\|
\| \*\*Date\*\* \| DATE \| Primary date key \| 2024-03-15 \| \|
\*\*Year\*\* \| INT \| Calendar year \| 2024 \| \| \*\*Year_Text\*\* \|
STRING \| Year as text \| \"2024\" \| \| \*\*Quarter\*\* \| STRING \|
Quarter \| \"Q1\" \| \| \*\*Quarter_Number\*\* \| INT \| Quarter (1-4)
\| 1 \| \| \*\*Month\*\* \| STRING \| Month name \| \"March\" \| \|
\*\*Month_Short\*\* \| STRING \| Month abbreviation \| \"Mar\" \| \|
\*\*Month_Number\*\* \| INT \| Month (1-12) \| 3 \| \| \*\*Day\*\* \|
INT \| Day of month \| 15 \| \| \*\*Day_Name\*\* \| STRING \| Day of
week \| \"Friday\" \| \| \*\*Day_Short\*\* \| STRING \| Day abbreviation
\| \"Fri\" \| \| \*\*Week\*\* \| INT \| Week number \| 11 \| \|
\*\*Fiscal_Year\*\* \| INT \| Fiscal year (Apr-Mar) \| 2024 \| \|
\*\*Is_Weekend\*\* \| STRING \| Weekend indicator \| \"Weekday\" \|

\-\--

\## 4. Calculated Fields

\### 4.1 Financial Metrics

\#### Profit Margin % \`\`\` Formula: (Profit / Sales) × 100 Purpose:
Measure profitability as percentage of sales Interpretation:  - \>30%:
Excellent  - 20-30%: Good  - 10-20%: Average  - \<10%: Poor Example:
26.5% \`\`\`

\#### Gross Margin % \`\`\` Formula: ((Sales - COGS) / Sales) × 100
Purpose: Profit before operating expenses Interpretation: Should be
consistent with industry standards Example: 26.5% \`\`\`

\#### Discount % \`\`\` Formula: (Discounts / Gross_Sales) × 100
Purpose: Measure discount intensity Interpretation:  - 0%: No discount
 - 1-10%: Low discount  - 10-15%: Medium discount  - \>15%: High
discount Example: 6.8% \`\`\`

\#### Unit Economics \`\`\` Unit_Profit = Profit / Units_Sold Unit_Cost
= COGS / Units_Sold Sales_Per_Unit = Sales / Units_Sold \`\`\`

\#### Contribution Margin \`\`\` Contribution_Margin = Sales - COGS
(Variable Costs) Contribution_Margin_Pct = (Contribution_Margin / Sales)
× 100 Purpose: Measure covering fixed costs and profit \`\`\`

\### 4.2 Categorical Classifications

\#### Revenue Category \`\`\` Small: Sales \< \$10,000 Medium: Sales
\$10,000 - \$50,000 Large: Sales \$50,000 - \$100,000 Enterprise: Sales
\> \$100,000 \`\`\`

\#### Profit Category \`\`\` Loss: Profit \< \$0 Low Profit: Profit
\$0 - \$5,000 Medium Profit: Profit \$5,000 - \$20,000 High Profit:
Profit \> \$20,000 \`\`\`

\#### Discount Tier \`\`\` No Discount: discount_band = \"None\" Low
Discount: discount_band = \"Low\" (typically 5-10%) Medium Discount:
discount_band = \"Medium\" (typically 10-15%) High Discount:
discount_band = \"High\" (typically \>15%) \`\`\`

\#### ABC Classification \`\`\` Class A: Top 80% of profit (focus
products) Class B: Next 15% of profit (maintain) Class C: Last 5% of
profit (review/minimize) \`\`\`

\-\--

\## 5. Database Views

\### 5.1 view_monthly_pl

\*\*Description:\*\* Monthly Profit & Loss statement

\*\*Columns:\*\* - year, month_number, month_name - total_gross_sales,
total_discounts, total_net_sales - total_cogs, total_profit -
profit_margin_pct - num_transactions, total_units

\*\*Usage:\*\* Monthly financial reporting

\-\--

\### 5.2 view_product_performance

\*\*Description:\*\* Aggregated product metrics

\*\*Columns:\*\* - product - num_transactions, total_units_sold -
total_revenue, total_profit - avg_profit_margin - total_gross_sales,
total_discounts - avg_discount_pct

\*\*Usage:\*\* Product portfolio analysis

\-\--

\### 5.3 view_segment_analysis

\*\*Description:\*\* Business segment profitability

\*\*Columns:\*\* - segment - num_countries, num_products - total_sales,
total_profit, total_units - avg_profit_margin, segment_margin_pct

\*\*Usage:\*\* Segment comparison and strategy

\-\--

\### 5.4 view_country_performance

\*\*Description:\*\* Geographic performance metrics

\*\*Columns:\*\* - country - num_segments, num_products - total_sales,
total_profit, total_cogs - avg_margin

\*\*Usage:\*\* Regional analysis

\-\--

\### 5.5 view_discount_analysis

\*\*Description:\*\* Discount effectiveness metrics

\*\*Columns:\*\* - discount_band - num_transactions, total_units -
total_gross_sales, total_discount_amount - total_net_sales,
total_profit - avg_discount_pct, avg_profit_margin

\*\*Usage:\*\* Pricing strategy optimization

\-\--

\## 6. DAX Measures

\### 6.1 Core Financial Measures

\`\`\`dax Total_Sales = SUM(fact_sales\[sales\]) Total_Profit =
SUM(fact_sales\[profit\]) Total_COGS = SUM(fact_sales\[cogs\])
Total_Gross_Sales = SUM(fact_sales\[gross_sales\]) Total_Discounts =
SUM(fact_sales\[discounts\]) Total_Units_Sold =
SUM(fact_sales\[units_sold\]) \`\`\`

\### 6.2 Ratio Measures

\`\`\`dax Net_Profit_Margin_Pct = DIVIDE(\[Total_Profit\],
\[Total_Sales\], 0) \* 100

Gross_Margin_Pct = DIVIDE(\[Total_Sales\] - \[Total_COGS\],
\[Total_Sales\], 0) \* 100

Discount_Rate_Pct = DIVIDE(\[Total_Discounts\], \[Total_Gross_Sales\],
0) \* 100

COGS_Percentage = DIVIDE(\[Total_COGS\], \[Total_Sales\], 0) \* 100
\`\`\`

\### 6.3 Time Intelligence Measures

\`\`\`dax Sales_LY = CALCULATE(\[Total_Sales\],
SAMEPERIODLASTYEAR(Date_Dimension\[Date\]))

Sales_YoY_Growth = DIVIDE(\[Total_Sales\] - \[Sales_LY\], \[Sales_LY\],
0) \* 100

Sales_YTD = TOTALYTD(\[Total_Sales\], Date_Dimension\[Date\])

Sales_MTD = TOTALMTD(\[Total_Sales\], Date_Dimension\[Date\]) \`\`\`

\-\--

\## 7. Data Quality Rules

\### 7.1 Validation Rules

\*\*Rule 1: Financial Calculation Integrity\*\* \`\`\` gross_sales =
units_sold × sale_price (±\$0.01 tolerance) sales = gross_sales -
discounts profit = sales - cogs \`\`\`

\*\*Rule 2: Logical Constraints\*\* \`\`\` units_sold \> 0 sales ≥ 0
discounts ≥ 0 discounts ≤ gross_sales manufacturing_price \> 0
sale_price \> 0 \`\`\`

\*\*Rule 3: Date Validity\*\* \`\`\` transaction_date BETWEEN
\'2024-01-01\' AND \'2026-12-31\' month_number BETWEEN 1 AND 12 quarter
BETWEEN 1 AND 4 \`\`\`

\*\*Rule 4: Referential Integrity\*\* \`\`\` All products exist in
product master All segments exist in segment master All countries exist
in geography master \`\`\`

\### 7.2 Data Quality Metrics

\*\*Completeness:\*\* - Target: 100% for critical fields - Actual:
99.7% - Missing: \<0.3% (handled via imputation/removal)

\*\*Accuracy:\*\* - Calculation validation: 100% match -
Cross-verification: Passed

\*\*Consistency:\*\* - Text standardization: Title case applied - Date
formats: Uniform (YYYY-MM-DD) - Decimal precision: 2 places for currency

\*\*Timeliness:\*\* - Data freshness: Updated monthly - Last refresh:
\[Date\]

\-\--

\## 8. Glossary

\### Financial Terms

\*\*COGS (Cost of Goods Sold)\*\* - Definition: Direct costs
attributable to production of goods sold - Includes: Manufacturing
costs, materials, direct labor - Excludes: Operating expenses,
marketing, overhead

\*\*Gross Sales\*\* - Definition: Total revenue before any deductions -
Formula: Units Sold × Sale Price - Also known as: Top-line revenue

\*\*Net Sales\*\* - Definition: Revenue after deducting discounts and
returns - Formula: Gross Sales - Discounts - Used for: Profitability
calculations

\*\*Profit Margin\*\* - Definition: Percentage of revenue remaining
after all costs - Formula: (Profit / Sales) × 100 - Interpretation:
Higher is better

\*\*Contribution Margin\*\* - Definition: Revenue minus variable costs -
Formula: Sales - COGS - Purpose: Covers fixed costs and generates profit

\*\*Discount Band\*\* - Definition: Categorization of discount levels -
Categories: None, Low, Medium, High - Purpose: Pricing strategy analysis

\### Business Segments

\*\*Government\*\* - Description: Sales to government entities -
Characteristics: Larger deals, longer cycles

\*\*Enterprise\*\* - Description: Large corporate clients -
Characteristics: High volume, competitive pricing

\*\*Small Business (SMB)\*\* - Description: Small and medium
businesses - Characteristics: Smaller deals, higher margins

\*\*Midmarket\*\* - Description: Mid-sized companies - Characteristics:
Balance of volume and margin

\*\*Channel Partners\*\* - Description: Indirect sales through
resellers - Characteristics: Lower margins, higher volume

\### Analytical Terms

\*\*ABC Analysis\*\* - Definition: Inventory categorization technique -
Basis: Pareto principle (80/20 rule) - Application: Product portfolio
optimization

\*\*YoY (Year-over-Year)\*\* - Definition: Comparison to same period
last year - Formula: ((Current - Last Year) / Last Year) × 100 -
Purpose: Identify growth trends

\*\*MoM (Month-over-Month)\*\* - Definition: Comparison to previous
month - Formula: ((Current Month - Last Month) / Last Month) × 100 -
Purpose: Short-term trend analysis

\*\*Moving Average\*\* - Definition: Average over rolling time period -
Example: 3-month MA smooths monthly fluctuations - Purpose: Identify
underlying trends

\*\*Seasonality\*\* - Definition: Regular patterns in time series data -
Example: Q4 holiday sales spike - Application: Forecasting and planning

\-\--

\## 9. Data Lineage

\### Source to Target Mapping

\*\*Raw Data (Excel) → Cleaned Data (CSV) → Database (MySQL) → Dashboard
(Power BI)\*\*

\`\`\` financial_operations.xlsx ↓ (Python: data_cleaning.py)
cleaned_financial_data.csv ↓ (Python: feature_engineering.py)
enriched_financial_data.csv ↓ (Python: load_to_mysql.py) fact_sales
table (MySQL) ↓ (Power BI: Data connection) Power BI Dashboard \`\`\`

\-\--

\## 10. Change Log

\| Date \| Version \| Change Description \| Author \|
\|\-\-\-\-\--\|\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\|\-\-\-\-\-\-\--\|
\| 2025-01-15 \| 1.0 \| Initial data dictionary created \| \[Your Name\]
\| \| 2025-01-20 \| 1.1 \| Added calculated fields section \| \[Your
Name\] \| \| 2025-01-25 \| 1.2 \| Added DAX measures documentation \|
\[Your Name\] \|

\-\--

\## 11. Contact & Support

\*\*Data Owner:\*\* Finance Department \*\*Technical Contact:\*\*
\[Vishal Pal\] \*\*Email:\*\* \[i.vishalpal@gmail.com\]

\-\--

\*\*Document Status:\*\* Approved \*\*Classification:\*\* Internal Use
Only

\-\--

\*For questions about data definitions or to request changes, please
contact the data owner.\*
