WITH trips AS (
    SELECT * FROM {{ ref('stg_trips') }}
),
geo AS (
    SELECT * FROM {{ ref('stg_geography') }}
)

SELECT
    t.date_id,
    COALESCE(g.city, 'Unknown') AS city,
    COUNT(*) AS total_trips,
    ROUND(SUM(t.total_amount), 2) AS total_revenue
FROM trips t
LEFT JOIN geo g ON t.pickup_geography_id = g.geography_id
GROUP BY t.date_id, COALESCE(g.city, 'Unknown')
