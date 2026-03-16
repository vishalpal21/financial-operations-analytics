-- ============================================================================
-- FINANCIAL OPERATIONS DATABASE SCHEMA
-- ============================================================================

CREATE DATABASE IF NOT EXISTS financial_operations_db;
USE financial_operations_db;

-- Main fact table
CREATE TABLE fact_sales (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    segment VARCHAR(50),
    country VARCHAR(50),
    product VARCHAR(100),
    discount_band VARCHAR(50),
    units_sold INT,
    manufacturing_price DECIMAL(12, 2),
    sale_price DECIMAL(12, 2),
    gross_sales DECIMAL(15, 2),
    discounts DECIMAL(15, 2),
    sales DECIMAL(15, 2),
    cogs DECIMAL(15, 2),
    profit DECIMAL(15, 2),
    transaction_date DATE,
    month_number INT,
    month_name VARCHAR(20),
    year INT,
    
    -- Calculated metrics
    profit_margin_pct DECIMAL(10, 2),
    gross_margin_pct DECIMAL(10, 2),
    discount_pct DECIMAL(10, 2),
    unit_profit DECIMAL(10, 2),
    contribution_margin DECIMAL(15, 2),
    quarter INT,
    fiscal_year INT,
    
    -- Indexes for performance
    INDEX idx_date (transaction_date),
    INDEX idx_segment (segment),
    INDEX idx_country (country),
    INDEX idx_product (product),
    INDEX idx_year_month (year, month_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dimension: Product Details
CREATE TABLE dim_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) UNIQUE,
    product_category VARCHAR(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dimension: Geographic
CREATE TABLE dim_geography (
    geo_id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(50) UNIQUE,
    region VARCHAR(50),
    continent VARCHAR(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dimension: Segment
CREATE TABLE dim_segment (
    segment_id INT AUTO_INCREMENT PRIMARY KEY,
    segment_name VARCHAR(50) UNIQUE,
    segment_type VARCHAR(50),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- CREATE VIEWS FOR COMMON ANALYSES
-- ============================================================================

-- Monthly P&L Statement
CREATE OR REPLACE VIEW view_monthly_pl AS
SELECT 
    year,
    month_number,
    month_name,
    SUM(gross_sales) as total_gross_sales,
    SUM(discounts) as total_discounts,
    SUM(sales) as total_net_sales,
    SUM(cogs) as total_cogs,
    SUM(profit) as total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as profit_margin_pct,
    COUNT(*) as num_transactions,
    SUM(units_sold) as total_units
FROM fact_sales
GROUP BY year, month_number, month_name
ORDER BY year, month_number;

-- Product Performance
CREATE OR REPLACE VIEW view_product_performance AS
SELECT 
    product,
    COUNT(*) as num_transactions,
    SUM(units_sold) as total_units_sold,
    SUM(sales) as total_revenue,
    SUM(profit) as total_profit,
    ROUND(AVG(profit_margin_pct), 2) as avg_profit_margin,
    SUM(gross_sales) as total_gross_sales,
    SUM(discounts) as total_discounts,
    ROUND(SUM(discounts) / SUM(gross_sales) * 100, 2) as avg_discount_pct
FROM fact_sales
GROUP BY product
ORDER BY total_profit DESC;

-- Segment Analysis
CREATE OR REPLACE VIEW view_segment_analysis AS
SELECT 
    segment,
    COUNT(DISTINCT country) as num_countries,
    COUNT(DISTINCT product) as num_products,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    SUM(units_sold) as total_units,
    ROUND(AVG(profit_margin_pct), 2) as avg_profit_margin,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) as segment_margin_pct
FROM fact_sales
GROUP BY segment
ORDER BY total_profit DESC;

-- Geographic Performance
CREATE OR REPLACE VIEW view_country_performance AS
SELECT 
    country,
    COUNT(DISTINCT segment) as num_segments,
    COUNT(DISTINCT product) as num_products,
    SUM(sales) as total_sales,
    SUM(profit) as total_profit,
    SUM(cogs) as total_cogs,
    ROUND(AVG(profit_margin_pct), 2) as avg_margin
FROM fact_sales
GROUP BY country
ORDER BY total_sales DESC;

-- Discount Effectiveness
CREATE OR REPLACE VIEW view_discount_analysis AS
SELECT 
    discount_band,
    COUNT(*) as num_transactions,
    SUM(units_sold) as total_units,
    SUM(gross_sales) as total_gross_sales,
    SUM(discounts) as total_discount_amount,
    SUM(sales) as total_net_sales,
    SUM(profit) as total_profit,
    ROUND(AVG(discount_pct), 2) as avg_discount_pct,
    ROUND(AVG(profit_margin_pct), 2) as avg_profit_margin
FROM fact_sales
GROUP BY discount_band
ORDER BY avg_discount_pct;