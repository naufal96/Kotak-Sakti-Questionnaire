-- Database: postgres
drop table customers;
drop table invoices;
drop table invoice_lines;

CREATE TABLE customers
(id varchar,
name varchar,
email varchar,
tel varchar,
created_at varchar,
updated_at varchar
);

CREATE TABLE invoices
(id varchar,
number varchar,
sub_total varchar,
tax_total varchar,
total varchar,
customer_id varchar,
created_at varchar,
updated_at varchar
);

CREATE TABLE invoice_lines
(id varchar,
description varchar,
unit_price varchar,
quantity varchar,
sub_total varchar,
tax_total varchar,
total varchar,
tax_id varchar,
sku_id varchar,
invoice_id varchar
);


-- Import data
COPY customers
FROM 'C:\Users\Naufal\Documents\Google DA\Kotak Sakti\customers.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM customers;

COPY invoices
FROM 'C:\Users\Naufal\Documents\Google DA\Kotak Sakti\invoices.csv'
DELIMITER ','
CSV HEADER;


COPY invoice_lines
FROM 'C:\Users\Naufal\Documents\Google DA\Kotak Sakti\invoice_lines.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM invoice_lines;


-- SOALAN 1
SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
   table_name = 'customers';

SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
   table_name = 'invoices';
   
SELECT 
   table_name, 
   column_name, 
   data_type 
FROM 
   information_schema.columns
WHERE 
   table_name = 'invoice_lines';


-- SOALAN 2
with df4 as (
  SELECT *
  FROM invoice_lines
  LEFT JOIN invoices ON invoices.id = invoice_lines.invoice_id
  LEFT JOIN customers ON customers.id = invoices.customer_id
),
df5 as (
  select name, sum(CAST(quantity AS int)) as quantity
  from df4
  group by name 
),
df6 as (
  select *
  from df5
  where quantity >= 5
)

select *
from df6;


--SOALAN 3

with df4 as (
  SELECT *
  FROM invoice_lines
  LEFT JOIN invoices ON invoices.id = invoice_lines.invoice_id
  LEFT JOIN customers ON customers.id = invoices.customer_id
),
df5 as (
  select name, sum(CAST(quantity AS int)) as quantity
  from df4
  group by name 
),
df6 as (
  select *
  from df5
  where quantity >= 5
),
df1 as (
  select *
  from customers  
),
df7 as (
  select df1.*, 
  df5.quantity
  from df1
  left join df5 ON df5.name = df1.name
),
df8 as (
  select name, coalesce(quantity, 0 ) as new_quantity
  from df7
)

select *
from df8
where new_quantity = 0 ;


--SOALAN 4

with df4 as (
  SELECT *
  FROM invoice_lines
  LEFT JOIN invoices ON invoices.id = invoice_lines.invoice_id
  LEFT JOIN customers ON customers.id = invoices.customer_id
)
select
  name, 
  string_agg (description, ',') as book_list
from df4
  group by name ;











