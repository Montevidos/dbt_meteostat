SELECT *, 
    date_part('day', date), 
    to_char(date, 'FMmonth') as month, 
    to_char(date, 'FMday') as day,
    case 
        when to_char(date, 'FMmonth') in ('december','january','february') then 'winter'
        when to_char(date, 'FMmonth') in ('march', 'april', 'may') then 'spring'
        when to_char(date, 'FMmonth') in ('june', 'july', 'august') then 'summer'
        else 'autumn'
    end as season
FROM {{ ref('stg_weather_daily') }}