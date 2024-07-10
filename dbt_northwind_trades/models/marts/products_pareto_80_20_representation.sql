-- Passo 1: Calcular o total de vendas por produto
with
    total_sales_per_product as (
        select 
            product_sk
            , sum(subtotal) as total_sales
        from {{ ref('fact_order_details') }}
        group by product_sk
    )

    -- Percentual de cada produto em relação ao total geral de vendas
    , product_percentages as (
        select 
            product_sk
            , total_sales
            , total_sales * 100.0 / sum(total_sales) over () as percentage_sales
        from total_sales_per_product
    )

    -- produtos pelo total de vendas em ordem decrescente p/ calcular o percentual acumulado
    , ordered_products as (
        select 
            product_sk
            , total_sales
            , percentage_sales
            , sum(percentage_sales) over (
                order by percentage_sales desc
            ) as cumulative_percentage
        from product_percentages
    )

    --Produtos que contribuem para 80% das vendas totais
    , pareto_80_20 as (
        select 
            products.product_name
            , products.category_name
            , products.supplier_company_name

            , ordered_products.total_sales
            , ordered_products.percentage_sales
            , ordered_products.cumulative_percentage
            , case when ordered_products.cumulative_percentage <= 80 
                then 'Top 20%'
                else '80% Restante' 
            end as pareto_80_20
        from ordered_products
        left join {{ ref('dim_products') }} products
            on ordered_products.product_sk = products.product_sk
        where products.is_discontinued = false
    )
select *
from pareto_80_20
order by cumulative_percentage
