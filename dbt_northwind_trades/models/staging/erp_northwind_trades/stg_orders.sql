with
    src_orders as (
        select 
            cast(order_id as int) as order_id
            , cast(customer_id as varchar) as customer_id
            , cast(employee_id as int) as employee_id
            , cast(ship_via as int) as shipper_id
            , cast(order_date as date) as order_date
            , cast(required_date as date) as required_date
            , cast(shipped_date as date) as shipped_date
            , cast(freight as decimal) as freight
            , cast(ship_name as varchar) as ship_name
            , cast(ship_address as varchar) as ship_address
            , cast(ship_city as varchar) as ship_city
            , cast(ship_region as varchar) as ship_region
            , cast(ship_postal_code as varchar) as ship_postal_code
            , cast(ship_country as varchar) as ship_country
        from {{ source('erp_northwind_trades', 'orders') }} 
    )
select *  
from src_orders