with 
    ---- trimestral ----
    tri_lastast_months_customers as (
        select distinct
            customer_sk
            , order_date
        from {{ ref('fact_order_details') }}
        where
            to_date(order_date, 'YYYY-MM-DD') >= (
                select date(to_date(max(order_date), 'YYYY-MM-DD') - interval '03 month')
                from {{ ref('fact_order_details') }}
            )
    )

    , tri_customers as (
        select distinct
            customer_sk
            , order_date
        from {{ ref('fact_order_details') }}
        where
            to_date(order_date, 'YYYY-MM-DD') <= (
                select date(to_date(max(order_date), 'YYYY-MM-DD') - interval '03 month')
                from {{ ref('fact_order_details') }}
            )
    )

    , tri_customers_churned as (
        select tri_customers.*
        from tri_customers
        left join tri_lastast_months_customers
            on tri_customers.customer_sk = tri_lastast_months_customers.customer_sk
        where tri_lastast_months_customers.customer_sk is null
    )

    , tri_churn_rate as (
        select 
            count(customer_sk) as customers_churned
            , (
                count(customer_sk)::float 
                / (select count(customer_sk)::float from tri_lastast_months_customers)
            ) * 100.00 as churn_rate
        from tri_customers_churned        
    )

---- semestral ----
    , sem_lastast_months_customers as (
        select distinct
            customer_sk
            , order_date
        from {{ ref('fact_order_details') }}
        where
            to_date(order_date, 'YYYY-MM-DD') >= (
                select date(to_date(max(order_date), 'YYYY-MM-DD') - interval '06 month')
                from {{ ref('fact_order_details') }}
            )
    )

    , sem_customers as (
        select distinct
            customer_sk
            , order_date
        from {{ ref('fact_order_details') }}
        where
            to_date(order_date, 'YYYY-MM-DD') <= (
                select date(to_date(max(order_date), 'YYYY-MM-DD') - interval '06 month')
                from {{ ref('fact_order_details') }}
            )
    )

    , sem_customers_churned as (
        select sem_customers.*
        from sem_customers
        left join sem_lastast_months_customers
            on sem_customers.customer_sk = sem_lastast_months_customers.customer_sk
        where sem_lastast_months_customers.customer_sk is null
    )

    , sem_churn_rate as (
        select 
            count(customer_sk) as customers_churned
            , (
                count(customer_sk)::float 
                / (select count(customer_sk)::float from sem_lastast_months_customers)
            ) * 100.00 as churn_rate
        from sem_customers_churned        
    )

---- anual ----
    , anual_lastast_months_customers as (
        select distinct
            customer_sk
            , order_date
        from {{ ref('fact_order_details') }}
        where
            to_date(order_date, 'YYYY-MM-DD') >= (
                select date(to_date(max(order_date), 'YYYY-MM-DD') - interval '12 month')
                from {{ ref('fact_order_details') }}
            )
    )

    , anual_customers as (
        select distinct
            customer_sk
            , order_date
        from {{ ref('fact_order_details') }}
        where
            to_date(order_date, 'YYYY-MM-DD') <= (
                select date(to_date(max(order_date), 'YYYY-MM-DD') - interval '12 month')
                from {{ ref('fact_order_details') }}
            )
    )

    , anual_customers_churned as (
        select anual_customers.*
        from anual_customers
        left join anual_lastast_months_customers
            on anual_customers.customer_sk = anual_lastast_months_customers.customer_sk
        where anual_lastast_months_customers.customer_sk is null
    )

    , anual_churn_rate as (
        select 
            count(customer_sk) as customers_churned
            , (
                count(customer_sk)::float 
                / (select count(customer_sk)::float from anual_lastast_months_customers)
            ) * 100.00 as churn_rate
        from anual_customers_churned        
    )

    , union_period as (
        select
            'anual' as period
            , *
        from anual_churn_rate
        union all
        select
            'trimestre' as period
            , *
        from tri_churn_rate
        union all
        select
            'semestre' as period
            , *
        from sem_churn_rate  
    )

select *
from union_period
