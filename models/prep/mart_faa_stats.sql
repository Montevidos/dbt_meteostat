SELECT
    ap.faa AS airport_code,
    ap.name AS airport_name,
    ap.city,
    ap.country,

    -- Уникальные вылеты и прибытия
    COUNT(DISTINCT CASE WHEN f.origin = ap.faa THEN f.dest END) AS unique_departure_connections,
    COUNT(DISTINCT CASE WHEN f.dest = ap.faa THEN f.origin END) AS unique_arrival_connections,

    -- Всего рейсов
    COUNT(CASE WHEN f.origin = ap.faa OR f.dest = ap.faa THEN 1 END) AS total_flights_planned,

    -- Отменённые
    COUNT(CASE WHEN f.cancelled = 1 AND (f.origin = ap.faa OR f.dest = ap.faa) THEN 1 END) AS total_cancelled,

    -- Отклонённые
    COUNT(CASE WHEN f.diverted = 1 AND (f.origin = ap.faa OR f.dest = ap.faa) THEN 1 END) AS total_diverted,

    -- Выполненные
    COUNT(CASE WHEN f.cancelled = 0 AND f.diverted = 0
               AND (f.origin = ap.faa OR f.dest = ap.faa) THEN 1 END) AS total_actual,

    -- Уникальные авиакомпании и самолёты
    COUNT(DISTINCT f.airline) AS unique_airlines,
    COUNT(DISTINCT f.tail_number) AS unique_aircraft

FROM {{ ref('prep_airports') }} ap
LEFT JOIN {{ ref('prep_flights') }} f
    ON f.origin = ap.faa OR f.dest = ap.faa
GROUP BY ap.faa, ap.name, ap.city, ap.country
ORDER BY total_flights_planned DESC