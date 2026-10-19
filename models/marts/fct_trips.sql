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
    
    -- Financial Measures transformed via Macro
    {{ to_dollars('fare_amount') }} AS fare_amount,
    {{ to_dollars('tip_amount') }} AS tip_amount,
    {{ to_dollars('surcharge_amount') }} AS surcharge_amount,
    {{ to_dollars('tax_amount') }} AS tax_amount,
    {{ to_dollars('tolls_amount') }} AS tolls_amount,
    {{ to_dollars('total_amount') }} AS total_amount
FROM trips