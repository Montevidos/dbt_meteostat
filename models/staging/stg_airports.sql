with airports_regions as (
select * from {{ source ('flights_data','airports')}}
join {{ source ('flights_data', 'regions')}}
using (country))
select * from airports_regions