with orders as(
select
	sum(qty_order) as total_qty_order,
	sum(total_price) as total_revenue
from
	master_sales),
return as (
select
	sum(qty_return) as total_qty_return,
	sum(lost_cost) as total_lost_cost
from
	master_return)
select
	o.total_qty_order,
	o.total_revenue,
	r.total_qty_return,
	r.total_lost_cost,
	round((r.total_qty_return::numeric / nullif(o.total_qty_order,0))*100 ,2) as return_rate
from orders o cross join return r;
	
	


with orders as(
select product_key, sum(qty_order) as qty_order from master_sales group by product_key),
return as(
select product_key, sum(qty_return) as qty_return from master_return group by product_key)
select
	p.product_key,
	p.product_name,
	o.qty_order,
	r.qty_return
from
	master_product p
left join orders o on
	p.product_key = o.product_key
inner join return r on
	p.product_key = r.product_key
order by
	r.qty_return desc;



select
	p.product_name,
	sum(s.qty_order)as qty_order,
	sum(r.qty_return) as qty_return
from
	master_product p
left join master_sales s on
	p.product_key = s.product_key
left join master_return r on
	s.product_key = r.product_key
group by
	p.product_name
having
	sum(r.qty_return) is not null
order by
	sum(r.qty_return) desc;




select
	country,
	sum(lost_cost) as total_lost_cost,
	sum(qty_return) as total_qty_return
from
	master_return
group by
	country
order by
	total_lost_cost desc;




select
	date_trunc('month', return_date) as bulan,
	sum(lost_cost) as total_lost_cost,
	sum(qty_return) as total_qty_return
from
	master_return
group by
	date_trunc('month', return_date)
order by
	total_lost_cost desc;



	
select
	date_trunc('month', order_date) as bulan,
	round(sum(total_price),2) as total_revenue
from
	master_sales
group by
	date_trunc('month', order_date)
order by
	total_revenue desc;


	
	
WITH total_sales AS (
    SELECT product_key, SUM(qty_order) AS total_order
    FROM master_sales
    GROUP BY product_key
),
total_return AS (
    SELECT product_key, SUM(qty_return) AS total_return
    FROM master_return
    GROUP BY product_key
)
SELECT 
    p.product_name,
    ROUND((COALESCE(r.total_return, 0)::numeric / NULLIF(s.total_order, 0)) * 100, 2) AS return_rate
FROM master_product p
LEFT JOIN total_sales s ON p.product_key = s.product_key
LEFT JOIN total_return r ON p.product_key = r.product_key
group by p.product_name,r.total_return,s.total_order
having ROUND((COALESCE(r.total_return, 0)::numeric / NULLIF(s.total_order, 0)) * 100, 2) is not null
ORDER BY return_rate DESC;
