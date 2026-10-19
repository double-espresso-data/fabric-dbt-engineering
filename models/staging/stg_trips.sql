{{ config(materialized='ephemeral') }}

WITH source_data AS (
    SELECT * 
    FROM {{ source('taxi_raw', 'Trip') }}
)

SELECT
    DateID AS date_id,
    PickupGeographyID AS pickup_geography_id,
    DropoffGeographyID AS dropoff_geography_id,
    PassengerCount AS passenger_count,
    TripDistanceMiles AS trip_distance_miles,
    PaymentType AS payment_type,
    FareAmount AS fare_amount,
    TipAmount AS tip_amount,
    TotalAmount AS total_amount
FROM source_data
WHERE PassengerCount > 0
  AND TripDistanceMiles > 0
  AND FareAmount >= 2.50
