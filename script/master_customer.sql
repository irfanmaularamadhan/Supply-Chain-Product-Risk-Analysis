select * from adventureworks_customer_lookup acl 

create view master_customer as
select
	"CustomerKey" as customer_key,
	trim (concat_ws(' ', "Prefix", "FirstName", "LastName")) as nama_customer,
	"BirthDate" as birth_date,
	"Gender" as gender
from
	adventureworks_customer_lookup
where
	"CustomerKey" is not null