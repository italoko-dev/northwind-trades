with 
    src_shippers as (
        select 
            cast(shipper_id as int) as shipper_id
            , cast(company_name as varchar) as company_name
            , cast(phone as varchar) as phone
        from {{ source('erp_northwind_trades', 'shippers') }}
    )
select *  
from src_shippers
