WITH trips AS (
    SELECT * 
    FROM {{ ref('stg_trips') }}
)
SELECT
    -- Foreign Keys for Star Schema joins
    date_id,
    pickup_geography_id,
    dropoff_geography_id,
    medallion_id,
    hackney_license_id,
    pickup_time_id,
    dropoff_time_id,
    -- Degenerate Dimension
    payment_type,
    -- Numerical Facts / Measures
    passenger_count,
    trip_duration_seconds,
    trip_distance_miles,
    fare_amount,
    tip_amount,
    surcharge_amount,
    tax_amount,
    tolls_amount,
    total_amount
FROM trips