{{
    config(
        materialized='table',
    )
}}

SELECT
    InvoiceNo as invoice_number,
    StockCode as stock_code,
    Description as description,
    Quantity as quantity,
    strptime(InvoiceDate, '%m/%d/%Y %H:%M') as invoice_date,
    UnitPrice as unit_price,
    CustomerID as customer_id,
    Country as country_name
FROM read_csv(
    '{{ var("csv_path") }}/commerce.csv',
    store_rejects=true
)
