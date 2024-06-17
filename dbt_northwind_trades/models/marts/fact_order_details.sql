with
    fact_order_details as (
        select
            orders.order_id
            , shipper.shipper_sk
            , customer.customer_sk
            , product.product_sk
            , employee.employee_sk

            , orders.order_date
            , dim_date.order_date_year
            , dim_date.order_date_month
            , dim_date.order_date_day

            , orders.required_date
            , orders.shipped_date
            , orders.ship_name
            , orders.ship_address
            , orders.ship_city
            , orders.ship_region
            , orders.ship_postal_code
            , orders.ship_country
            
            , order_details.order_unit_price
            , order_details.quantity
            , order_details.discount
            , cast(
                (order_details.order_unit_price * quantity) - discount as decimal
            ) as subtotal
            , orders.freight
        from {{ ref('stg_orders') }}  orders
        left join {{ ref('stg_order_details') }} order_details
            on orders.order_id = order_details.order_id
        left join {{ ref('dim_date') }} dim_date
            on orders.order_date = dim_date.order_date
        left join {{ ref('dim_shippers') }} shipper
            on orders.shipper_id = shipper.shipper_id
        left join {{ ref('dim_customers') }} customer
            on orders.customer_id = customer.customer_id
        left join {{ ref('dim_products') }} product
            on order_details.product_id = product.product_id
        left join {{ ref('dim_employees') }} employee
            on orders.employee_id = employee.employee_id
    )

select *
from fact_order_details
