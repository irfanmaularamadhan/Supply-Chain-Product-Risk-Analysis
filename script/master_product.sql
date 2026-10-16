select*from adventureworks_product_categories_lookup apcl;
select*from adventureworks_product_subcategories_lookup apsl;
select*from adventureworks_product_lookup apl;


create view master_product as
select
	p."ProductKey" as product_key,
	s."ProductCategoryKey" as product_category_key,
	p."ProductSubcategoryKey" as product_subcategory_key,
	p."ProductName" as product_name,
	c."CategoryName" as product_category,
	s."SubcategoryName" as product_subcategory,
	p."ProductCost" as product_cost,
	p."ProductPrice" as product_price
from
	adventureworks_product_lookup p
join adventureworks_product_subcategories_lookup s on
	p."ProductSubcategoryKey" = s."ProductSubcategoryKey"
join adventureworks_product_categories_lookup c on
	s."ProductCategoryKey" = c."ProductCategoryKey"
	
select
	product_name,
	product_cost,
	product_category,
	product_price
from
	master_product mp
where
	product_category = 'Bikes'
	order by product_cost asc 

