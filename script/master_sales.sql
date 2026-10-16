select*from adventureworks_sales_data asd;
select*from master_product;
select*from master_customer;
select*from master_return;
select*from adventureworks_territory_lookup;
select*from adventureworks_discounts



create view master_sales as
SELECT
    o."OrderDate" AS order_date,
    o."OrderNumber" AS order_number,
    o."ProductKey" AS product_key,
    p.product_category_key,
    o."CustomerKey" AS customer_key,
    o."TerritoryKey" AS territory_key,
    p.product_name,
    p.product_category,
    p.product_cost,
    p.product_price,
    c.nama_customer,
    t."Region" AS region,
    t."Country" AS country,
    o."OrderQuantity" AS qty_order,
    COALESCE(d."DiscountRate", 0) AS discount_rate,
    ROUND(((p.product_price * o."OrderQuantity") * (1 - COALESCE(d."DiscountRate", 0)))::numeric, 2) AS total_price
FROM adventureworks_sales_data o
LEFT JOIN master_product p ON o."ProductKey" = p.product_key
LEFT JOIN master_customer c ON o."CustomerKey" = c.customer_key
LEFT JOIN adventureworks_territory_lookup t ON o."TerritoryKey" = t."SalesTerritoryKey"
LEFT JOIN adventureworks_discounts d ON p.product_category_key = d."ProductCategoryKey"
    AND EXTRACT('year' FROM o."OrderDate") = d."Year";