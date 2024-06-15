with
    stg_products as (
        select
            products.product_id
            , products.product_name
            
            , products.category_id
            , categories.category_name
            , categories.category_description

            , products.supplier_id
            , suppliers.supplier_company_name
            , suppliers.supplier_contact_name
            , suppliers.supplier_contact_title
            , suppliers.supplier_address
            , suppliers.supplier_city
            , suppliers.supplier_region
            , suppliers.supplier_postal_code
            , suppliers.supplier_country
            , suppliers.supplier_phone
            , suppliers.supplier_fax
            , suppliers.supplier_home_page
            
            , products.quantity_per_unit
            , products.unit_price
            , products.units_in_stock
            , products.units_on_order
            , products.reorder_level
            , products.is_discontinued
        from {{ ref('stg_products') }} as products 
        left join {{ ref('stg_categories') }} as categories 
            on products.category_id = categories.category_id
        left join {{ ref('stg_suppliers') }} as suppliers
            on products.supplier_id = suppliers.supplier_id
    )

    , dim_products_create_sk as (
        select 
            md5(
                cast(product_id as varchar)
                || cast(category_id as varchar)
                || cast(supplier_id as varchar)
            ) as product_sk
            , *
        from stg_products
    )

select *
from dim_products_create_sk
