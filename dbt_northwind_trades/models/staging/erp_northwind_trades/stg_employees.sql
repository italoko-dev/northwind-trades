with
    src_employees as (
        select 
            cast(employee_id as int) as employee_id
            , cast(title_of_courtesy as varchar) as title_of_courtesy
            , cast(last_name as varchar) as last_name
            , cast(first_name as varchar) as first_name
            , cast(title as varchar) as title
            , cast(
                title_of_courtesy || first_name || ' ' || last_name as varchar
            ) as full_name
            , cast(birth_date as date) as birth_date
            , cast(hire_date as date) as hire_date
            , cast(address as varchar) as address
            , cast(city as varchar) as city
            , cast(region as varchar) as region
            , cast(postal_code as varchar) as postal_code
            , cast(country as varchar) as country
            , cast(home_phone as varchar) as home_phone
            , cast(extension as varchar) as extension
            , cast(photo as varchar) as photo
            , cast(photo_path as varchar) as photo_path
            , cast(reports_to as int) as reports_to
            , cast(notes as varchar) as notes
        from {{ source('erp_northwind_trades', 'employees') }}
    )
select *  
from src_employees
