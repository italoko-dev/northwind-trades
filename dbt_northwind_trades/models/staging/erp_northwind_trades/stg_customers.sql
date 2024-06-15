with 
    src_customers as (
        select 
            cast(customer_id as varchar) as customer_id
            , cast(company_name as varchar) as customer_company_name
            , cast(contact_name as varchar) as customer_contact_name
            , cast(contact_title as varchar) as customer_contact_title
            , cast(address as varchar) as customer_address
            , cast(city as varchar) as customer_city
            , cast(region as varchar) as customer_region
            , cast(postal_code as varchar) as customer_postal_code
            , cast(country as varchar) as customer_country
            , cast(phone as varchar) as customer_phone
            , cast(fax as varchar) as customer_fax
        from {{ source('erp_northwind_trades', 'customers') }}
    )
select *  
from src_customers
