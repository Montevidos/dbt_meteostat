SELECT *,
    timestamp::DATE AS date,
    timestamp::TIME AS time,
    TO_CHAR(timestamp, 'FMmonth') AS month_name,
    TO_CHAR(timestamp, 'FMDay') AS weekday,
    DATE_PART('day', timestamp) AS date_day,
    DATE_PART('month', timestamp) AS date_month,
    DATE_PART('year', timestamp) AS date_year,
    DATE_PART('week', timestamp) AS cw,
    CASE
        WHEN timestamp::TIME BETWEEN '00:00:00' AND '05:59:59' THEN 'night'
        WHEN timestamp::TIME BETWEEN '06:00:00' AND '11:59:59' THEN 'morning'
        WHEN timestamp::TIME BETWEEN '12:00:00' AND '17:59:59' THEN 'day'
        ELSE 'evening'
    END AS day_part
FROM {{ ref('stg_weather_hourly') }}