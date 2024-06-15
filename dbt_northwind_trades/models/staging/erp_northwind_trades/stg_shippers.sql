with 
    src_shippers as (
        select 
            cast(shipper_id as int) as shipper_id
            , cast(company_name as varchar) as shipper_company_name
            , cast(phone as varchar) as shipper_phone
        from {{ source('erp_northwind_trades', 'shippers') }}
    )
select *  
from src_shippers
