create database cs4;
use cs4;

##Q1
## What was the total quantity sold for all products?
select details.product_name,
sum(sales.qty) as sales_counts
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details.product_name
order by sales_counts desc;



##Q2
##  What is the total generated revenue for all products before discounts?
select sum(price*qty) as no_dis_revenue
from sales;


##Q3
## What was the total discount amount for all products?
select sum(price*qty*discount)/100 as total_discount
from sales;

##Q4
## How many unique transactions were there?
select count(distinct txn_id) as unique_txn
from sales;


##Q5
## What are the average unique products purchased in each transaction?
with cte_transaction_products as (
select txn_id,
count(distinct prod_id) as product_count
from sales
group by txn_id)
select round(avg(product_count)) as avg_unique_products
from cte_transaction_products;

##Q6
## What is the average discount value per transaction?
 with cte_transaction_discount as (
select txn_id,
sum(price*qty*discount)/100 as total_discount
from sales
group by txn_id)
select round(avg(total_discount)) as avg_discount
from cte_transaction_discount;

##Q7
## What is the average revenue for member transactions and nonmember transactio
 with cte_member_revenue as(
 select member, txn_id, sum(price*qty) as revenue
 from sales
 group by member, txn_id)
 select member, round(avg(revenue),2) as avg_revenue
 from cte_member_revenue
 group by member;

##Q8
## What are the top 3 products by total revenue before discount?
select details.product_name,sum(qty*sales.price) as no_dis_revenue
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details.product_name
order by no_dis_revenue desc
limit 3;

##Q9
## What are the total quantity, revenue and discount for each segment?
select details.segment_id,
details.segment_name,
sum(sales.qty) as total_quantity,
sum(sales.qty*sales.price) as total_revenue,
sum(sales.qty*sales.price*sales.discount)/100 as total_duscount
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details.segment_id,details.segment_name;

##Q10
## What is the top selling product for each segment?
select details.segment_id,
details.segment_name,
details.product_id,details.product_name,
sum(sales.qty) as product_quantity
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details.segment_id,details.segment_name,
details.product_id,details.product_name   
order by product_quantity desc
limit 5;

##Q11
## What are the total quantity, revenue and discount for each category?
select details.category_id,
details.category_name,
sum(sales.qty) as total_quantity,
sum(sales.qty*sales.price) as total_revenue,
sum(sales.qty*sales.price*sales.discount)/100 as total_duscount
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details.category_id,details.category_name;

##Q12
##  What is the top selling product for each category?
select details.category_id,
details.category_name,
details.product_id,details.product_name,
sum(sales.qty) as product_quantity
from sales inner join product_details as details
on sales.prod_id=details.product_id
group by details.category_id,details.category_name,
details.product_id,details.product_name   
order by product_quantity desc
limit 5;


