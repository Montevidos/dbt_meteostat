WITH flights AS (
    SELECT 
        *,
        TO_CHAR(dep_time, 'fm0000')::TIME AS dep_time_formatted,
        TO_CHAR(arr_time, 'fm0000')::TIME AS arr_time_formatted,
        TO_CHAR(sched_dep_time, 'fm0000')::TIME AS sched_dep_time_formatted,
        TO_CHAR(sched_arr_time, 'fm0000')::TIME AS sched_arr_time_formatted,
        (dep_delay * '1 minute'::interval) AS dep_delay_interval,
        (distance / 0.621371) AS distance_km

    FROM {{ ref('stg_flights_one_month') }}
)

SELECT *
FROM flights