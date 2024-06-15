with
    src_suppliers as (
        select 
            cast(supplier_id as int) as supplier_id
            , cast(company_name as varchar) as company_name
            , cast(contact_name as varchar) as contact_name
            , cast(contact_title as varchar) as contact_title
            , cast(address as varchar) as address
            , cast(city as varchar) as city
            , cast(region as varchar) as region
            , cast(postal_code as varchar) as postal_code
            , cast(country as varchar) as country
            , cast(phone as varchar) as phone
            , cast(fax as varchar) as fax
            , cast(homepage as varchar) as home_page
        from {{ source('erp_northwind_trades', 'suppliers') }}
    )
select *
from src_suppliers
