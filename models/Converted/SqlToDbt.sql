{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('orders') }}
),

customer as (
    select * from {{ ref('customer') }}
),

product as (
    select * from {{ ref('product') }}
)

select
    o.order_id,
    c.customer_name,
    c.segment,
    p.product_name,
    p.category,
    p.subcategory,
    o.order_date,
    o.ship_date,
    o.ship_mode,
    o.order_cost_price,
    o.order_selling_price,
    case
        when (o.order_selling_price - o.order_cost_price) > 0 then 'Profit'
        when (o.order_selling_price - o.order_cost_price) = 0 then 'Break-even'
        else 'Loss'
    end as profit_status,
    case
        when o.order_cost_price > 0 then round(((o.order_selling_price - o.order_cost_price) / o.order_cost_price) * 100, 2)
        else null
    end as profit_margin,
    case
        when c.segment = 'Corporate' and o.order_cost_price > 500 then 'High Value Corporate'
        when c.segment = 'Consumer' and o.order_cost_price < 200 then 'Low Value Consumer'
        else 'Other'
    end as customer_category
from orders o
inner join customer c on o.customer_id = c.customer_id
inner join product p on o.product_id = p.product_id
where o.order_date >= '2022-01-01'
and c.country = 'United States'
group by o.order_id, c.customer_name, c.segment, p.product_name, p.category, p.subcategory, o.order_date, o.ship_date, o.ship_mode, o.order_cost_price, o.order_selling_price, c.state
having count(o.order_id) >= 1
order by profit_margin desc, c.customer_name asc
