select * from adventureworks_returns_data ard;
select*from adventureworks_territory_lookup;
select*from adventureworks_product_lookup apl;
select*from master_product;


create view master_return as
select
	r."ReturnDate" as return_date,
	r."TerritoryKey" as territory_key,
	r."ProductKey" as product_key,
	t."Region" as region,
	t."Country" as country,
	p.product_name,
	r."ReturnQuantity" as qty_return,
	p.product_cost as lost_cost
from
	adventureworks_returns_data r
join adventureworks_territory_lookup t on
	r."TerritoryKey" = t."SalesTerritoryKey"
join master_product p on
	r."ProductKey" = p.product_key
	
	

	
	