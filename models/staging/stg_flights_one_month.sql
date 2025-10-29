{{ config(materialized='view') }}
with flights_filtered as (
    select * from {{ source('flights_data', 'flights') }}
    where flight_date::timestamp between '2024-01-01' and '2024-01-31'
)

select * from flights_filtered