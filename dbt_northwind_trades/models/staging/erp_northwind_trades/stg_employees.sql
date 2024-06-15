with
    src_employees as (
        select 
            cast(employee_id as int) as employee_id
            , cast(title_of_courtesy as varchar) as employee_title_of_courtesy
            , cast(last_name as varchar) as employee_last_name
            , cast(first_name as varchar) as employee_first_name
            , cast(title as varchar) as employee_title
            , cast(
                title_of_courtesy || first_name || ' ' || last_name as varchar
            ) as employee_full_name
            , cast(birth_date as date) as employee_birth_date
            , cast(hire_date as date) as employee_hire_date
            , cast(address as varchar) as employee_address
            , cast(city as varchar) as employee_city
            , cast(region as varchar) as employee_region
            , cast(postal_code as varchar) as employee_postal_code
            , cast(country as varchar) as employee_country
            , cast(home_phone as varchar) as employee_home_phone
            , cast(extension as varchar) as employee_extension
            , cast(photo as varchar) as employee_photo
            , cast(photo_path as varchar) as employee_photo_path
            , cast(reports_to as int) as employee_reports_to
            , cast(notes as varchar) as employee_notes
        from {{ source('erp_northwind_trades', 'employees') }}
    )
select *  
from src_employees
