-- ============================================================================
-- FINANCIAL OPERATIONS - BUSINESS INTELLIGENCE SQL QUERIES
-- ============================================================================
-- Database: financial_operations_db
-- Purpose: Comprehensive financial analysis and reporting queries
-- ============================================================================

USE financial_operations_db;

-- ============================================================================
-- SECTION 1: PROFIT & LOSS (P&L) REPORTING
-- ============================================================================

-- 1.1 Complete P&L Statement (All Time)
SELECT 
    'Gross Sales' as line_item,
    SUM(gross_sales) as amount,
    100.00 as pct_of_sales
FROM fact_sales
UNION ALL
SELECT 
    'Less: Discounts',
    SUM(discounts),
    ROUND(SUM(discounts) / SUM(gross_sales) * 100, 2)
FROM fact_sales
UNION ALL
SELECT 
    'Net Sales',
    SUM(sales),
    100.00
FROM fact_sales
UNION ALL
SELECT 
    'Cost of Goods Sold',
    SUM(cogs),
    ROUND(SUM(cogs) / SUM(sales) * 100, 2)
FROM fact_sales
UNION ALL
SELECT 
    'Gross Profit',
    SUM(sales) - SUM(cogs),
    ROUND((SUM(sales) - SUM(cogs)) / SUM(sales) * 100, 2)
FROM fact_sales
UNION ALL
SELECT 
    'Net Profit',
    SUM(profit),
    ROUND(SUM(profit) / SUM(sales) * 100, 2)
FROM fact_sales;

-- 1.2 Monthly P&L Statement
SELECT 
    year,
    month_name,
    SUM(gross_sales) as gross_sales,
    SUM(discounts) as total_discounts,
    SUM(sales) as net_sales,
    SUM(cogs) as total_cogs,
    SUM(profit) as net_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as profit_margin_pct,
    SUM(units_sold) as units_sold
FROM fact_sales
GROUP BY year, month_number, month_name
ORDER BY year, month_number;

-- 1.3 Quarterly P&L Summary
SELECT 
    year,
    CONCAT('Q', quarter) as quarter,
    SUM(sales) as total_sales,
    SUM(cogs) as total_cogs,
    SUM(profit) as total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as profit_margin_pct,
    COUNT(*) as num_transactions
FROM fact_sales
GROUP BY year, quarter
ORDER BY year, quarter;

-- 1.4 Year-over-Year P&L Comparison
SELECT 
    year,
    SUM(sales) as annual_sales,
    SUM(profit) as annual_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as profit_margin,
    LAG(SUM(sales)) OVER (ORDER BY year) as prev_year_sales,
    LAG(SUM(profit)) OVER (ORDER BY year) as prev_year_profit,
    ROUND(
        (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY year)) / 
        LAG(SUM(sales)) OVER (ORDER BY year) * 100, 
        2
    ) as sales_growth_pct,
    ROUND(
        (SUM(profit) - LAG(SUM(profit)) OVER (ORDER BY year)) / 
        LAG(SUM(profit)) OVER (ORDER BY year) * 100, 
        2
    ) as profit_growth_pct
FROM fact_sales
GROUP BY year
ORDER BY year;

-- ============================================================================
-- SECTION 2: PROFITABILITY ANALYSIS
-- ============================================================================

-- 2.1 Product Profitability Ranking
SELECT 
    product,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    SUM(cogs) as total_cogs,
    SUM(units_sold) as total_units,
    ROUND(AVG(profit_margin_pct), 2) as avg_margin_pct,
    ROUND(SUM(profit) / SUM(units_sold), 2) as profit_per_unit,
    ROUND(SUM(profit) / (SELECT SUM(profit) FROM fact_sales) * 100, 2) as profit_contribution_pct,
    RANK() OVER (ORDER BY SUM(profit) DESC) as profit_rank
FROM fact_sales
GROUP BY product
ORDER BY total_profit DESC;

-- 2.2 Segment Profitability Analysis
SELECT 
    segment,
    COUNT(DISTINCT product) as num_products,
    COUNT(DISTINCT country) as num_countries,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    SUM(cogs) as total_cogs,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as profit_margin_pct,
    ROUND(SUM(sales) / COUNT(*), 2) as avg_transaction_value,
    ROUND(SUM(profit) / (SELECT SUM(profit) FROM fact_sales) * 100, 2) as profit_share_pct
FROM fact_sales
GROUP BY segment
ORDER BY total_profit DESC;

-- 2.3 Country Profitability Matrix
SELECT 
    country,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    SUM(units_sold) as total_units,
    ROUND(AVG(profit_margin_pct), 2) as avg_margin,
    COUNT(DISTINCT segment) as num_segments,
    COUNT(DISTINCT product) as num_products,
    ROUND(SUM(sales) / (SELECT SUM(sales) FROM fact_sales) * 100, 2) as sales_contribution_pct
FROM fact_sales
GROUP BY country
ORDER BY total_profit DESC;

-- 2.4 High vs Low Margin Products
SELECT 
    CASE 
        WHEN avg_margin >= 40 THEN 'High Margin (>=40%)'
        WHEN avg_margin >= 20 THEN 'Medium Margin (20-40%)'
        ELSE 'Low Margin (<20%)'
    END as margin_category,
    COUNT(DISTINCT product) as num_products,
    SUM(total_sales) as total_sales,
    SUM(total_profit) as total_profit,
    ROUND(AVG(avg_margin), 2) as avg_profit_margin
FROM (
    SELECT 
        product,
        SUM(sales) as total_sales,
        SUM(profit) as total_profit,
        AVG(profit_margin_pct) as avg_margin
    FROM fact_sales
    GROUP BY product
) product_margins
GROUP BY margin_category
ORDER BY avg_profit_margin DESC;

-- 2.5 Loss-Making Transactions Analysis
SELECT 
    segment,
    product,
    country,
    COUNT(*) as num_loss_transactions,
    SUM(sales) as total_sales,
    SUM(profit) as total_loss,
    ROUND(AVG(profit_margin_pct), 2) as avg_margin,
    SUM(units_sold) as units_sold
FROM fact_sales
WHERE profit < 0
GROUP BY segment, product, country
ORDER BY total_loss;

-- ============================================================================
-- SECTION 3: DISCOUNT ANALYSIS
-- ============================================================================

-- 3.1 Discount Band Effectiveness
SELECT 
    discount_band,
    COUNT(*) as num_transactions,
    SUM(units_sold) as total_units,
    SUM(gross_sales) as gross_sales,
    SUM(discounts) as total_discounts,
    SUM(sales) as net_sales,
    SUM(profit) as total_profit,
    ROUND(AVG(discount_pct), 2) as avg_discount_pct,
    ROUND(AVG(profit_margin_pct), 2) as avg_profit_margin,
    ROUND(SUM(sales) / SUM(units_sold), 2) as avg_price_per_unit
FROM fact_sales
GROUP BY discount_band
ORDER BY avg_discount_pct;

-- 3.2 Discount Impact on Profitability by Segment
SELECT 
    segment,
    discount_band,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    ROUND(AVG(profit_margin_pct), 2) as avg_margin,
    SUM(units_sold) as units_sold,
    ROUND(AVG(discount_pct), 2) as avg_discount
FROM fact_sales
GROUP BY segment, discount_band
ORDER BY segment, avg_discount;

-- 3.3 Optimal Discount Analysis (Profit Maximization)
SELECT 
    discount_band,
    product,
    SUM(units_sold) as units_sold,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    ROUND(SUM(profit) / SUM(units_sold), 2) as profit_per_unit,
    ROUND(AVG(profit_margin_pct), 2) as avg_margin
FROM fact_sales
GROUP BY discount_band, product
HAVING SUM(profit) > 0
ORDER BY product, total_profit DESC;

-- 3.4 Discount vs Volume Analysis
SELECT 
    discount_band,
    ROUND(AVG(discount_pct), 2) as avg_discount_pct,
    SUM(units_sold) as total_units_sold,
    SUM(sales) as total_sales,
    ROUND(SUM(sales) / SUM(units_sold), 2) as avg_selling_price,
    COUNT(DISTINCT product) as num_products,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as profit_margin_pct
FROM fact_sales
GROUP BY discount_band
ORDER BY total_units_sold DESC;

-- ============================================================================
-- SECTION 4: COST ANALYSIS
-- ============================================================================

-- 4.1 COGS Breakdown by Product
SELECT 
    product,
    SUM(cogs) as total_cogs,
    SUM(sales) as total_sales,
    ROUND(SUM(cogs) / SUM(sales) * 100, 2) as cogs_pct_of_sales,
    SUM(units_sold) as total_units,
    ROUND(SUM(cogs) / SUM(units_sold), 2) as cogs_per_unit,
    ROUND(AVG(manufacturing_price), 2) as avg_manufacturing_cost
FROM fact_sales
GROUP BY product
ORDER BY total_cogs DESC;

-- 4.2 Manufacturing Cost Trends
SELECT 
    year,
    month_name,
    AVG(manufacturing_price) as avg_mfg_cost,
    AVG(sale_price) as avg_sale_price,
    AVG(sale_price - manufacturing_price) as avg_markup,
    ROUND(AVG((sale_price - manufacturing_price) / manufacturing_price * 100), 2) as avg_markup_pct
FROM fact_sales
GROUP BY year, month_number, month_name
ORDER BY year, month_number;

-- 4.3 Cost-to-Serve by Country
SELECT 
    country,
    SUM(cogs) as total_cogs,
    SUM(sales) as total_sales,
    SUM(units_sold) as total_units,
    ROUND(SUM(cogs) / SUM(units_sold), 2) as avg_cost_per_unit,
    ROUND(SUM(cogs) / SUM(sales) * 100, 2) as cogs_percentage,
    SUM(profit) as total_profit
FROM fact_sales
GROUP BY country
ORDER BY total_cogs DESC;

-- 4.4 High-Cost vs Low-Cost Products
SELECT 
    CASE 
        WHEN avg_cogs_per_unit >= 100 THEN 'High Cost (>=100)'
        WHEN avg_cogs_per_unit >= 50 THEN 'Medium Cost (50-100)'
        ELSE 'Low Cost (<50)'
    END as cost_category,
    COUNT(DISTINCT product) as num_products,
    SUM(total_cogs) as total_cogs,
    SUM(total_profit) as total_profit,
    ROUND(AVG(avg_cogs_per_unit), 2) as avg_unit_cost
FROM (
    SELECT 
        product,
        SUM(cogs) as total_cogs,
        SUM(profit) as total_profit,
        SUM(cogs) / SUM(units_sold) as avg_cogs_per_unit
    FROM fact_sales
    GROUP BY product
) product_costs
GROUP BY cost_category
ORDER BY avg_unit_cost DESC;

-- ============================================================================
-- SECTION 5: SALES PERFORMANCE
-- ============================================================================

-- 5.1 Top 20 Transactions by Revenue
SELECT 
    transaction_id,
    transaction_date,
    segment,
    country,
    product,
    units_sold,
    sales,
    profit,
    profit_margin_pct,
    discount_band
FROM fact_sales
ORDER BY sales DESC
LIMIT 20;

-- 5.2 Monthly Sales Performance Metrics
SELECT 
    year,
    month_name,
    SUM(sales) as total_sales,
    SUM(units_sold) as total_units,
    COUNT(*) as num_transactions,
    ROUND(AVG(sales), 2) as avg_transaction_value,
    ROUND(SUM(sales) / SUM(units_sold), 2) as avg_price_per_unit,
    COUNT(DISTINCT product) as num_products_sold,
    COUNT(DISTINCT country) as num_countries
FROM fact_sales
GROUP BY year, month_number, month_name
ORDER BY year, month_number;

-- 5.3 Sales Growth Trends
SELECT 
    year,
    month_name,
    SUM(sales) as monthly_sales,
    LAG(SUM(sales)) OVER (ORDER BY year, month_number) as prev_month_sales,
    ROUND(
        (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY year, month_number)) /
        LAG(SUM(sales)) OVER (ORDER BY year, month_number) * 100,
        2
    ) as mom_growth_pct
FROM fact_sales
GROUP BY year, month_number, month_name
ORDER BY year, month_number;

-- 5.4 Best and Worst Performing Months
(
    SELECT 
        'Best Month' as category,
        year,
        month_name,
        SUM(sales) as total_sales,
        SUM(profit) as total_profit
    FROM fact_sales
    GROUP BY year, month_number, month_name
    ORDER BY total_profit DESC
    LIMIT 5
)
UNION ALL
(
    SELECT 
        'Worst Month' as category,
        year,
        month_name,
        SUM(sales) as total_sales,
        SUM(profit) as total_profit
    FROM fact_sales
    GROUP BY year, month_number, month_name
    ORDER BY total_profit ASC
    LIMIT 5
)
ORDER BY category DESC, total_profit DESC;

-- ============================================================================
-- SECTION 6: VARIANCE ANALYSIS
-- ============================================================================

-- 6.1 Month-over-Month Variance
SELECT 
    year,
    month_name,
    SUM(sales) as current_sales,
    SUM(profit) as current_profit,
    LAG(SUM(sales)) OVER (ORDER BY year, month_number) as prev_sales,
    LAG(SUM(profit)) OVER (ORDER BY year, month_number) as prev_profit,
    SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY year, month_number) as sales_variance,
    SUM(profit) - LAG(SUM(profit)) OVER (ORDER BY year, month_number) as profit_variance,
    ROUND(
        (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY year, month_number)) /
        LAG(SUM(sales)) OVER (ORDER BY year, month_number) * 100,
        2
    ) as sales_change_pct
FROM fact_sales
GROUP BY year, month_number, month_name
ORDER BY year, month_number;

-- 6.2 Product Performance Variance (YoY)

-- Automatically compares the latest year vs previous year in your data
SELECT 
    product,
    SUM(CASE WHEN year = (SELECT MAX(year) FROM fact_sales) THEN sales ELSE 0 END) as current_year_sales,
    SUM(CASE WHEN year = (SELECT MAX(year) - 1 FROM fact_sales) THEN sales ELSE 0 END) as last_year_sales,
    SUM(CASE WHEN year = (SELECT MAX(year) FROM fact_sales) THEN profit ELSE 0 END) as current_year_profit,
    SUM(CASE WHEN year = (SELECT MAX(year) - 1 FROM fact_sales) THEN profit ELSE 0 END) as last_year_profit,
    SUM(CASE WHEN year = (SELECT MAX(year) FROM fact_sales) THEN sales ELSE 0 END) - 
        SUM(CASE WHEN year = (SELECT MAX(year) - 1 FROM fact_sales) THEN sales ELSE 0 END) as sales_variance,
    ROUND(
        (SUM(CASE WHEN year = (SELECT MAX(year) FROM fact_sales) THEN sales ELSE 0 END) -
         SUM(CASE WHEN year = (SELECT MAX(year) - 1 FROM fact_sales) THEN sales ELSE 0 END)) /
        NULLIF(SUM(CASE WHEN year = (SELECT MAX(year) - 1 FROM fact_sales) THEN sales ELSE 0 END), 0) * 100,
        2
    ) as sales_growth_pct,
    ROUND(
        (SUM(CASE WHEN year = (SELECT MAX(year) FROM fact_sales) THEN profit ELSE 0 END) -
         SUM(CASE WHEN year = (SELECT MAX(year) - 1 FROM fact_sales) THEN profit ELSE 0 END)) /
        NULLIF(SUM(CASE WHEN year = (SELECT MAX(year) - 1 FROM fact_sales) THEN profit ELSE 0 END), 0) * 100,
        2
    ) as profit_growth_pct
FROM fact_sales
GROUP BY product
HAVING last_year_sales > 0
ORDER BY sales_growth_pct DESC;

-- ============================================================================
-- SECTION 7: CONTRIBUTION ANALYSIS
-- ============================================================================

-- 7.1 Contribution Margin by Product
SELECT 
    product,
    SUM(sales) as total_sales,
    SUM(contribution_margin) as total_contribution,
    ROUND(AVG(contribution_margin_pct), 2) as avg_contribution_margin_pct,
    SUM(units_sold) as units_sold,
    ROUND(SUM(contribution_margin) / SUM(units_sold), 2) as contribution_per_unit,
    ROUND(SUM(contribution_margin) / (SELECT SUM(contribution_margin) FROM fact_sales) * 100, 2) as contribution_share_pct
FROM fact_sales
GROUP BY product
ORDER BY total_contribution DESC;

-- 7.2 Pareto Analysis (80/20 Rule) - Products
SELECT 
    product,
    SUM(profit) as total_profit,
    ROUND(SUM(profit) / (SELECT SUM(profit) FROM fact_sales) * 100, 2) as profit_pct,
    ROUND(
        SUM(SUM(profit)) OVER (ORDER BY SUM(profit) DESC) / 
        (SELECT SUM(profit) FROM fact_sales) * 100,
        2
    ) as cumulative_profit_pct,
    CASE 
        WHEN ROUND(
            SUM(SUM(profit)) OVER (ORDER BY SUM(profit) DESC) / 
            (SELECT SUM(profit) FROM fact_sales) * 100,
            2
        ) <= 80 THEN 'Class A (Top 80%)'
        WHEN ROUND(
            SUM(SUM(profit)) OVER (ORDER BY SUM(profit) DESC) / 
            (SELECT SUM(profit) FROM fact_sales) * 100,
            2
        ) <= 95 THEN 'Class B (Next 15%)'
        ELSE 'Class C (Last 5%)'
    END as abc_classification
FROM fact_sales
GROUP BY product
ORDER BY total_profit DESC;

-- ============================================================================
-- SECTION 8: EXECUTIVE DASHBOARD QUERIES
-- ============================================================================

-- 8.1 Key Performance Indicators (KPIs)
SELECT 
    'Total Sales' as metric,
    CONCAT('$', FORMAT(SUM(sales), 2)) as value
FROM fact_sales
UNION ALL
SELECT 
    'Total Profit',
    CONCAT('$', FORMAT(SUM(profit), 2))
FROM fact_sales
UNION ALL
SELECT 
    'Profit Margin %',
    CONCAT(ROUND(SUM(profit) / SUM(sales) * 100, 2), '%')
FROM fact_sales
UNION ALL
SELECT 
    'Total Units Sold',
    FORMAT(SUM(units_sold), 0)
FROM fact_sales
UNION ALL
SELECT 
    'Average Transaction Value',
    CONCAT('$', FORMAT(AVG(sales), 2))
FROM fact_sales
UNION ALL
SELECT 
    'Number of Products',
    COUNT(DISTINCT product)
FROM fact_sales
UNION ALL
SELECT 
    'Number of Countries',
    COUNT(DISTINCT country)
FROM fact_sales
UNION ALL
SELECT 
    'Average Discount Rate',
    CONCAT(ROUND(AVG(discount_pct), 2), '%')
FROM fact_sales;

-- 8.2 Current Month Performance
SELECT 
    'Current Month' as period,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as profit_margin,
    SUM(units_sold) as units_sold
FROM fact_sales
WHERE year = YEAR(CURDATE()) 
  AND month_number = MONTH(CURDATE())
UNION ALL
SELECT 
    'Previous Month',
    SUM(sales),
    SUM(profit),
    ROUND(SUM(profit) / SUM(sales) * 100, 2),
    SUM(units_sold)
FROM fact_sales
WHERE year = YEAR(DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
  AND month_number = MONTH(DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- ============================================================================
-- SECTION 9: FORECASTING SUPPORT QUERIES
-- ============================================================================

-- 9.1 Moving Average (3-Month)
SELECT 
    year,
    month_name,
    SUM(sales) as monthly_sales,
    ROUND(
        AVG(SUM(sales)) OVER (
            ORDER BY year, month_number 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) as moving_avg_3month
FROM fact_sales
GROUP BY year, month_number, month_name
ORDER BY year, month_number;

-- 9.2 Seasonality Analysis
SELECT 
    month_name,
    AVG(sales) as avg_monthly_sales,
    AVG(profit) as avg_monthly_profit,
    AVG(units_sold) as avg_monthly_units,
    ROUND(AVG(profit_margin_pct), 2) as avg_profit_margin,
    COUNT(DISTINCT year) as years_of_data
FROM fact_sales
GROUP BY month_number, month_name
ORDER BY month_number;

-- ============================================================================
-- END OF SQL QUERIES
-- ============================================================================
