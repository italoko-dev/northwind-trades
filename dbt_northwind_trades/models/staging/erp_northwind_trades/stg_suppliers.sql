with
    src_suppliers as (
        select 
            cast(supplier_id as int) as supplier_id
            , cast(company_name as varchar) as supplier_company_name
            , cast(contact_name as varchar) as supplier_contact_name
            , cast(contact_title as varchar) as supplier_contact_title
            , cast(address as varchar) as supplier_address
            , cast(city as varchar) as supplier_city
            , cast(region as varchar) as supplier_region
            , cast(postal_code as varchar) as supplier_postal_code
            , cast(country as varchar) as supplier_country
            , cast(phone as varchar) as supplier_phone
            , cast(fax as varchar) as supplier_fax
            , cast(homepage as varchar) as supplier_home_page
        from {{ source('erp_northwind_trades', 'suppliers') }}
    )
select *
from src_suppliers
