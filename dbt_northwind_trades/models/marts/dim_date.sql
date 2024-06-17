{{
    config(
        materialized='ephemeral'
    )
}}

with
    dates as (
        select distinct order_date
        from {{ ref('stg_orders') }}
    )

    , dim_date as (
        select
            cast(order_date as varchar) as order_date
            , cast(date_part('year', to_date(order_date, 'YYYY-MM-DD')) as int) as order_date_year
            , cast(date_part('month', to_date(order_date, 'YYYY-MM-DD')) as int) as order_date_month
            , cast(date_part('day', to_date(order_date, 'YYYY-MM-DD')) as int) as order_date_day
            , cast(date_part('week', to_date(order_date, 'YYYY-MM-DD')) as int) as order_date_week
            , cast(date_part('quarter', to_date(order_date, 'YYYY-MM-DD')) as int) as order_date_quarter
            , cast(date_part('isodow', to_date(order_date, 'YYYY-MM-DD')) as int) as day_of_week
        from dates
        order by order_date 
    )
select *
from dim_date
