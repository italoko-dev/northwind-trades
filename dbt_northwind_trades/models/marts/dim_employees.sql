with
    territories as (
        select
            territories.territory_id
            , territories.territory_description
            , territories.region_id

            , region.region_description
        from {{ ref('stg_territories') }} as territories
        left join {{ ref('stg_region') }} as region
            on territories.region_id = region.region_id
    )

    , employee_territories as (
        select 
            emp_territory.employee_id
            , territories.*
        from {{ ref('stg_employee_territories') }} as emp_territory
        left join territories
            on emp_territory.territory_id = territories.territory_id
    )

    , stg_employees as (
        select 
            employee.employee_id
            , employee.employee_title_of_courtesy
            , employee.employee_last_name
            , employee.employee_first_name
            , employee.employee_title
            , employee.employee_full_name
            , employee.employee_birth_date
            , cast(
                current_date - employee.employee_birth_date as int
            ) / 365 as employee_age
            , employee.employee_hire_date
            , cast(
                current_date - employee.employee_hire_date as int
            ) as employee_company_time_in_days
            , employee.employee_address
            , employee.employee_city
            , employee.employee_region
            , employee.employee_postal_code
            , employee.employee_country

            , emp_territories.territory_id
            , emp_territories.territory_description
            , emp_territories.region_id
            , emp_territories.region_description

            , employee.employee_home_phone
            , employee.employee_extension
            , employee.employee_photo
            , employee.employee_photo_path
            , coalesce(
                employee_report_to.employee_full_name
                , 'N/A'
            ) as employee_reports_to
            , employee.employee_notes
        from {{ ref('stg_employees') }} as employee
        left join {{ ref('stg_employees') }} as employee_report_to
            on employee.employee_reports_to = employee_report_to.employee_id
        left join employee_territories as emp_territories
            on employee.employee_id = emp_territories.employee_id
    )

    , dim_employees_create_sk as (
        select 
            md5(
                cast(employee_id as varchar)
                || cast(territory_id as varchar)
                || cast(region_id as varchar)
            ) as employee_sk
            , *
        from stg_employees
    )

select *
from dim_employees_create_sk
