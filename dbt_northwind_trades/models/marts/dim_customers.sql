with
    customer_customer_demo as (
        select
            customer_cust_demo.customer_id
            , customer_cust_demo.customer_type_id

            , customer_demo.customer_desc
        from {{ ref('stg_customer_customer_demo') }} as customer_cust_demo
        left join {{ ref('stg_customer_demographics') }} as customer_demo
            on customer_cust_demo.customer_type_id=customer_demo.customer_type_id
    )

    , stg_customers as (
        select
            customer.customer_id
            , customer.customer_company_name
            , customer.customer_contact_name
            , customer.customer_contact_title
            , customer.customer_address
            , customer.customer_city
            , customer.customer_region
            , customer.customer_postal_code
            , customer.customer_country
            , customer.customer_phone
            , customer.customer_fax

            , coalesce(
                customer_customer_demo.customer_type_id
                , 'N/I'
            ) as customer_type_id
            , coalesce(
                customer_customer_demo.customer_desc
                , 'N/I'
            ) as customer_desc
        from {{ ref('stg_customers') }} as customer
        left join customer_customer_demo
            on customer.customer_id=customer_customer_demo.customer_id
    )

    , dim_customers_create_sk as (
        select 
            md5(
                cast(customer_id as varchar)
                || cast(customer_type_id as varchar)
            ) as employee_sk
            , *
        from stg_customers
    )


select *
from dim_customers_create_sk
