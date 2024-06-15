with
    src_us_states as (
        select 
            cast(state_id as int) as state_id
            , cast(state_name as varchar) as state_name
            , cast(state_abbr as varchar) as state_abbr
            , cast(state_region as varchar) as state_region
        from {{ ref('us_states') }}
    )
select *
from src_us_states
