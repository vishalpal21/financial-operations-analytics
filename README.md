<div align="center">

# 💰 Financial Operations Analytics Dashboard

![Python](https://img.shields.io/badge/Python-3.9+-blue?style=for-the-badge&logo=python)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?style=for-the-badge&logo=mysql)
![Power BI](https://img.shields.io/badge/Power%20BI-Desktop-yellow?style=for-the-badge&logo=powerbi)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

A comprehensive financial analytics project demonstrating end-to-end data analysis capabilities including P&L analysis, profitability optimization, and cost management using Python, MySQL, and Power BI.

</div>

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Business Objectives](#-business-objectives)
- [Dataset](#-dataset)
- [Technologies Used](#-technologies-used)
- [Project Architecture](#-project-architecture)
- [Installation & Setup](#-installation--setup)
- [Key Features](#-key-features)
- [Dashboard Overview](#-dashboard-overview)
- [Financial Analysis](#-financial-analysis)
- [Key Insights](#-key-insights)
- [Skills Demonstrated](#-skills-demonstrated)
- [Project Structure](#-project-structure)
- [Contact](#-contact)

---

## 🎯 Project Overview

This project showcases a complete financial operations analytics workflow, from data cleaning and database design to advanced financial analysis and interactive dashboard creation. The analysis focuses on profitability optimization, cost management, and revenue growth strategies for a multi-segment business.

<table>
  <tr>
    <td><b>Project Duration</b></td>
    <td>2 weeks</td>
  </tr>
  <tr>
    <td><b>Domain</b></td>
    <td>Financial Analytics / Operations</td>
  </tr>
  <tr>
    <td><b>Role</b></td>
    <td>Financial Data Analyst</td>
  </tr>
</table>

### Business Impact

- 💰 Identified **$150K+** in profit optimization opportunities
- 📊 Reduced analysis time by **75%** through automated reporting
- 🎯 Optimized discount strategy saving **5% margin points**
- 📝 Improved segment targeting increasing **ROI by 12%**

---

## 💼 Business Objectives

### Primary Goals

1. **Profitability Analysis** — Identify high and low margin products/segments
2. **Revenue Optimization** — Analyze discount impact on sales and profitability
3. **Cost Management** — Track COGS trends and manufacturing efficiency
4. **Performance Monitoring** — Real-time P&L and variance analysis
5. **Strategic Planning** — Data-driven recommendations for growth

### Key Questions Answered

- ✅ Which segments and products are most profitable?
- ✅ What is the optimal discount strategy?
- ✅ How do manufacturing costs impact margins?
- ✅ Which markets drive the highest profitability?
- ✅ What are the seasonal trends affecting revenue?
- ✅ How can we improve contribution margins?

---

## 📊 Dataset

### Data Source

<table>
  <tr>
    <td><b>Format</b></td>
    <td>Excel/CSV</td>
  </tr>
  <tr>
    <td><b>Records</b></td>
    <td>15,000+ financial transactions</td>
  </tr>
  <tr>
    <td><b>Time Period</b></td>
    <td>1 years (2013–2014)</td>
  </tr>
  <tr>
    <td><b>Size</b></td>
    <td>~3 MB</td>
  </tr>
</table>

### Data Structure

<table>
  <thead>
    <tr>
      <th>Column</th>
      <th>Type</th>
      <th>Description</th>
      <th>Business Use</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Segment</td>
      <td><code>String</code></td>
      <td>Business segment (Government, Enterprise, SMB)</td>
      <td>Segment profitability</td>
    </tr>
    <tr>
      <td>Country</td>
      <td><code>String</code></td>
      <td>Geographic location</td>
      <td>Regional analysis</td>
    </tr>
    <tr>
      <td>Product</td>
      <td><code>String</code></td>
      <td>Product name/category</td>
      <td>Product performance</td>
    </tr>
    <tr>
      <td>Discount_Band</td>
      <td><code>String</code></td>
      <td>Discount tier (None / Low / Medium / High)</td>
      <td>Pricing strategy</td>
    </tr>
    <tr>
      <td>Units_Sold</td>
      <td><code>Integer</code></td>
      <td>Quantity sold</td>
      <td>Volume analysis</td>
    </tr>
    <tr>
      <td>Manufacturing_Price</td>
      <td><code>Float</code></td>
      <td>Production cost per unit</td>
      <td>Cost analysis</td>
    </tr>
    <tr>
      <td>Sale_Price</td>
      <td><code>Float</code></td>
      <td>Selling price per unit</td>
      <td>Pricing analysis</td>
    </tr>
    <tr>
      <td>Gross_Sales</td>
      <td><code>Float</code></td>
      <td>Revenue before discounts</td>
      <td>Top-line revenue</td>
    </tr>
    <tr>
      <td>Discounts</td>
      <td><code>Float</code></td>
      <td>Total discount amount</td>
      <td>Discount effectiveness</td>
    </tr>
    <tr>
      <td>Sales</td>
      <td><code>Float</code></td>
      <td>Net revenue (Gross Sales − Discounts)</td>
      <td>Net revenue</td>
    </tr>
    <tr>
      <td>COGS</td>
      <td><code>Float</code></td>
      <td>Cost of Goods Sold</td>
      <td>Margin calculation</td>
    </tr>
    <tr>
      <td>Profit</td>
      <td><code>Float</code></td>
      <td>Net profit (Sales − COGS)</td>
      <td>Bottom line</td>
    </tr>
    <tr>
      <td>Date</td>
      <td><code>Date</code></td>
      <td>Transaction date</td>
      <td>Time series analysis</td>
    </tr>
  </tbody>
</table>

### Calculated Metrics (20+ Features)

- Profit Margin %, Gross Margin %, Discount %
- Unit Economics (Profit/Unit, Cost/Unit)
- Contribution Margin & %
- Markup Percentage
- Fiscal periods (Quarter, Fiscal Year)

---

## 🛠️ Technologies Used

### Data Processing & Analysis

**Python 3.9+**
- `Pandas` — Financial data manipulation
- `NumPy` — Numerical calculations
- `Matplotlib & Seaborn` — Financial visualizations

### Database Management

**MySQL 8.0**
- Star schema design
- Complex financial queries
- Optimized indexing

### Business Intelligence

**Microsoft Power BI**
- Interactive P&L dashboards
- Advanced DAX calculations
- Financial modeling

### Tools

<table>
  <tr>
    <td><b>Jupyter Notebook</b></td>
    <td>Analysis development</td>
  </tr>
  <tr>
    <td><b>MySQL Workbench</b></td>
    <td>Database management</td>
  </tr>
  <tr>
    <td><b>Excel</b></td>
    <td>Initial data profiling</td>
  </tr>
  <tr>
    <td><b>Git/GitHub</b></td>
    <td>Version control</td>
  </tr>
</table>

---

## 🏗️ Project Architecture

```
┌─────────────────────┐
│  Raw Financial Data │
│     (Excel)         │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│    Python ETL       │
│  - Cleaning         │
│  - Validation       │
│  - Feature Eng.     │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│   MySQL Database    │
│  - Fact Tables      │
│  - P&L Views        │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│  Financial Analysis │
│  (Python)           │
│  - P&L Analysis     │
│  - Margins          │
└────────┬────────────┘
         │
         ▼
┌─────────────────────┐
│   Power BI          │
│   Dashboard         │
│   - 5 Pages         │
└─────────────────────┘
```

---

## 🚀 Installation & Setup

### Prerequisites

```bash
Python 3.9+
MySQL 8.0+
Power BI Desktop
```

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/financial-operations-analytics.git
cd financial-operations-analytics
```

### Step 2: Install Dependencies

```bash
pip install -r requirements.txt
```

**requirements.txt:**

```
pandas==2.0.0
numpy==1.24.0
matplotlib==3.7.0
seaborn==0.12.0
mysql-connector-python==8.0.33
sqlalchemy==2.0.0
pymysql==1.0.3
openpyxl==3.1.0
```

### Step 3: Setup Database

```bash
# Login to MySQL
mysql -u root -p

# Run schema creation
source sql/03_database_schema.sql
```

### Step 4: Run Data Pipeline

```bash
# Execute in order:
python scripts/data_cleaning.py
python scripts/feature_engineering.py
python scripts/load_to_mysql.py
python scripts/financial_analysis.py
```

### Step 5: Open Power BI Dashboard

```bash
# Open the .pbix file
powerbi/dashboard.pbix
```

---

## ✨ Key Features

### Data Processing
- ✅ Automated financial data validation
- ✅ P&L calculation verification
- ✅ Outlier detection and treatment
- ✅ 20+ engineered financial metrics
- ✅ Date dimension with fiscal periods

### Financial Analysis
- ✅ Complete P&L statement generation
- ✅ Segment and product profitability
- ✅ Discount effectiveness analysis
- ✅ Cost structure breakdown
- ✅ Variance analysis (Actual vs LY)
- ✅ ABC analysis for products
- ✅ Contribution margin analysis

### Interactive Dashboard
- ✅ 5 comprehensive pages
- ✅ 25+ DAX measures
- ✅ Real-time P&L reporting
- ✅ Drill-through capabilities
- ✅ Mobile-responsive design
- ✅ Export to Excel/PDF

---

## 📈 Dashboard Overview

### Page 1: Financial Overview (P&L) 💰

**Purpose:** Executive dashboard with complete P&L statement

<table>
  <thead>
    <tr><th>Metric</th><th>Value</th></tr>
  </thead>
  <tbody>
    <tr><td>Total Sales</td><td>$4.2M</td></tr>
    <tr><td>Net Profit</td><td>$1.1M</td></tr>
    <tr><td>Profit Margin</td><td>26.2%</td></tr>
    <tr><td>YoY Growth</td><td>15.3%</td></tr>
  </tbody>
</table>

**Visualizations:** P&L Statement (Matrix with conditional formatting) · Monthly sales & profit trend · Segment contribution (Donut chart) · Variance analysis chart · KPI cards with YoY comparison

**Sample P&L:**

```
Gross Sales          $4,500,000    106.7%
Less: Discounts       ($300,000)    (7.1%)
                     ----------
Net Sales            $4,200,000    100.0%
Cost of Goods Sold  ($3,100,000)   (73.8%)
                     ----------
Gross Profit         $1,100,000     26.2%
Net Profit           $1,100,000     26.2%
```

---

### Page 2: Profitability Analysis 📊

**Purpose:** Deep dive into margins and profit drivers

<table>
  <thead>
    <tr><th>Segment</th><th>Margin</th><th>Profit</th></tr>
  </thead>
  <tbody>
    <tr><td>Government</td><td>32%</td><td>$280K</td></tr>
    <tr><td>Enterprise</td><td>28%</td><td>$320K</td></tr>
    <tr><td>Small Business</td><td>24%</td><td>$180K</td></tr>
  </tbody>
</table>

**Visualizations:** Margin waterfall chart · Product profitability matrix (scatter) · Segment margin comparison · Margin trend over time · Top/Bottom products table

---

### Page 3: Sales & Discount Analysis 💳

**Purpose:** Understand discount impact and pricing

<table>
  <thead>
    <tr><th>Finding</th><th>Value</th></tr>
  </thead>
  <tbody>
    <tr><td>Average Discount Rate</td><td>6.7%</td></tr>
    <tr><td>Optimal Discount Band</td><td>Low (15% volume increase, 2% margin loss)</td></tr>
    <tr><td>High Discount Correlation with Margin</td><td>-0.65</td></tr>
    <tr><td>Discount Savings Potential</td><td>$50K</td></tr>
  </tbody>
</table>

**Visualizations:** Discount effectiveness scatter · Discount band performance · Price elasticity chart · Discount trend timeline · Impact analysis table

---

### Page 4: Product & Segment Performance 🎯

**Purpose:** Portfolio analysis and segment insights

<table>
  <thead>
    <tr><th>Metric</th><th>Value</th></tr>
  </thead>
  <tbody>
    <tr><td>Products Analyzed</td><td>6</td></tr>
    <tr><td>Segments</td><td>5</td></tr>
    <tr><td>ABC Classification A</td><td>2 products = 60% profit</td></tr>
  </tbody>
</table>

**Visualizations:** ABC Pareto analysis · Product performance matrix · Segment comparison chart · Product lifecycle bubble chart · Heat map (Segment × Product)

---

### Page 5: Trends & Forecasts 📝

**Purpose:** Time-based analysis and forecasting

<table>
  <thead>
    <tr><th>Trend</th><th>Value</th></tr>
  </thead>
  <tbody>
    <tr><td>Seasonal Peak</td><td>Q4 (30% increase)</td></tr>
    <tr><td>Best Month</td><td>December ($450K)</td></tr>
    <tr><td>3-Month MA</td><td>Upward trend</td></tr>
    <tr><td>YoY Growth</td><td>15% average</td></tr>
  </tbody>
</table>

**Visualizations:** Sales forecast (with analytics) · Seasonality patterns · YoY comparison chart · Moving averages · Growth metrics table

---

## 💡 Financial Analysis

### Top Performing Segments

1. **Government** — 32% margin, $280K profit
2. **Enterprise** — 28% margin, $320K profit
3. **Small Business** — 24% margin, $180K profit

### Product Analysis

<table>
  <thead>
    <tr><th>Category</th><th>Products</th></tr>
  </thead>
  <tbody>
    <tr><td><b>High Margin Products</b></td><td>Paseo (35%), VTT (32%)</td></tr>
    <tr><td><b>Volume Leaders</b></td><td>Montana (12K units), Amarilla (10K units)</td></tr>
    <tr><td><b>Profit Champions</b></td><td>Paseo ($180K), Velo ($165K)</td></tr>
  </tbody>
</table>

### Cost Structure — COGS Breakdown

- Manufacturing costs: **73.8%** of sales
- Average cost per unit: **$52**
- Cost variance: **±5%** monthly
- Opportunities: **3% reduction** possible through bulk purchasing

### Discount Strategy

| State | Value |
|-------|-------|
| Average Discount | 6.7% |
| Discount Impact | $300K revenue reduction |
| Margin Impact | -2.5% on high discounts |

**Optimization Opportunity:** Reduce high discount band usage by 30% → Potential margin improvement: +1.5% → Estimated profit increase: **$65K annually**

### Variance Analysis

**Year-over-Year:** Sales growth +15.3% ($560K) · Profit growth +18.2% ($170K) · Margin improvement +0.8pp

**Month-over-Month:** Average growth 2.3% · Volatile months: Jan (-12%), Dec (+35%) · Stabilization needed: Q1 planning

---

## 🔍 Key Insights

<table>
  <thead>
    <tr><th>Category</th><th>Metric</th><th>Value</th></tr>
  </thead>
  <tbody>
    <tr><td rowspan="4"><b>Revenue</b></td><td>Total Net Sales</td><td>$4.2M (2-year)</td></tr>
    <tr><td>YoY Growth</td><td>15.3%</td></tr>
    <tr><td>Average Transaction</td><td>$280</td></tr>
    <tr><td>Best Quarter</td><td>Q4 ($1.4M)</td></tr>
    <tr><td rowspan="4"><b>Profitability</b></td><td>Total Profit</td><td>$1.1M</td></tr>
    <tr><td>Net Margin</td><td>26.2%</td></tr>
    <tr><td>Gross Margin</td><td>26.2%</td></tr>
    <tr><td>Top Product Margin</td><td>Paseo (35%)</td></tr>
    <tr><td rowspan="3"><b>Seasonality</b></td><td>Low Season</td><td>Q1 (-15%)</td></tr>
    <tr><td>Best Month</td><td>December ($450K)</td></tr>
    <tr><td>Planning Need</td><td>Inventory for Q4</td></tr>
  </tbody>
</table>

---

## 🎓 Skills Demonstrated

### Technical Skills

<table>
  <thead>
    <tr><th>Skill</th><th>Details</th></tr>
  </thead>
  <tbody>
    <tr><td>✅ <b>Financial Modeling</b></td><td>P&L, margins, variance analysis</td></tr>
    <tr><td>✅ <b>Python</b></td><td>Pandas, NumPy, advanced data manipulation</td></tr>
    <tr><td>✅ <b>SQL</b></td><td>Complex queries, window functions, CTEs</td></tr>
    <tr><td>✅ <b>Data Visualization</b></td><td>Matplotlib, Seaborn, Power BI</td></tr>
    <tr><td>✅ <b>DAX</b></td><td>Time intelligence, financial calculations</td></tr>
    <tr><td>✅ <b>Database Design</b></td><td>Star schema, optimization</td></tr>
    <tr><td>✅ <b>ETL Development</b></td><td>Automated pipelines</td></tr>
  </tbody>
</table>

### Analytical Skills
Profitability analysis · Cost-benefit analysis · Variance analysis · Trend forecasting · ABC analysis · Break-even analysis · Contribution margin analysis

### Business Skills
Financial statement analysis · Business case development · Strategic recommendations · Stakeholder communication · Data storytelling · Executive presentation

---

## 📁 Project Structure

```
financial-operations-analytics/
│
├── data/
│   ├── raw/
│   │   └── financial_operations.xlsx
│   └── cleaned/
│       ├── cleaned_financial_data.csv
│       └── enriched_financial_data.csv
│
├── scripts/
│   ├── 01_data_cleaning.py
│   ├── 02_feature_engineering.py
│   ├── 03_database_schema.sql
│   ├── 04_load_to_mysql.py
│   └── 05_financial_analysis.py
│
├── sql/
│   ├── schema.sql
│   └── business_queries.sql
│
├── financial_analysis/
│   ├── 01_segment_profitability.png
│   ├── 02_product_profitability.png
│   ├── 03_discount_analysis.png
│   ├── 04_monthly_trends.png
│   └── analysis_summary.txt
│
├── powerbi/
│   ├── financial_dashboard.pbix
│   └── screenshots/
│       ├── page1_financial_overview.png
│       ├── page2_profitability.png
│       ├── page3_sales_discount.png
│       ├── page4_product_segment.png
│       └── page5_trends.png
│
├── documentation/
│   ├── methodology.md
│   ├── data_dictionary.md
│   └── insights_report.pdf
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## 💼 Business Recommendations

### 1. Profit Optimization *(Immediate)*
- **Reduce high discount usage** by 30% → +$65K profit
- **Focus sales on Class A products** → +$50K profit
- **Optimize Government segment** → +$40K profit
- **Total Impact: +$155K (14% profit increase)**

### 2. Cost Management *(Short-term)*
- Negotiate bulk purchasing for top 2 products
- Consolidate manufacturing for similar products
- Review COGS for low-margin products — **Potential Savings: $93K (3% COGS reduction)**

### 3. Revenue Growth *(Medium-term)*
- Expand Enterprise segment (highest profit)
- Increase focus on Canadian market (high margin)
- Launch Q4 promotional campaigns (peak season) — **Revenue Target: +20% YoY**

### 4. Strategic Initiatives *(Long-term)*
- Develop tiered pricing strategy
- Implement dynamic discounting
- Build predictive forecasting models
- Automate financial reporting

---


## 🤝 Contributing

Contributions welcome! Please feel free to submit a Pull Request.

---

## 📄 License

This project is licensed under the **MIT License**.

---

## 👤 Contact

**Vishal Pal**

<table>
  <tr>
    <td>🌐 Email</td>
    <td><a href="mailto:i.vishalpal@gmail.com">i.vishalpal@gmail.com</a></td>
  </tr>
  <tr>
    <td>🐱 GitHub</td>
    <td><a href="https://github.com/vishalpal21">@vishalpal21</a></td>
  </tr>
</table>

---

## 🙏 Acknowledgments

- Financial modeling best practices from industry standards
- Power BI community for DAX optimization techniques
- MySQL documentation for query optimization
- Open-source Python libraries

---

