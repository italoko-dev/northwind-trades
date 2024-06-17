with 
    dim_shippers_create_sk as (
        select
            md5(cast(shipper_id as varchar)||shipper_company_name) as shipper_sk  
            , shipper_id
            , shipper_company_name
            , shipper_phone
        from {{ ref('stg_shippers') }}
    )
select *
from dim_shippers_create_sk
