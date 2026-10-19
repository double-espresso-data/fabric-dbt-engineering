{{ config(materialized='view') }}

WITH source_data AS (
    SELECT * 
    FROM {{ source('fabric_raw', 'Trip') }}
)

SELECT
    DateID AS date_id,
    MedallionID AS medallion_id,
    HackneyLicenseID AS hackney_license_id,
    PickupTimeID AS pickup_time_id,
    DropoffTimeID AS dropoff_time_id,
    PickupGeographyID AS pickup_geography_id,
    DropoffGeographyID AS dropoff_geography_id,
    PassengerCount AS passenger_count,
    TripDurationSeconds AS trip_duration_seconds,
    TripDistanceMiles AS trip_distance_miles,
    PaymentType AS payment_type,
    FareAmount AS fare_amount,
    SurchargeAmount AS surcharge_amount,
    TaxAmount AS tax_amount,
    TipAmount AS tip_amount,
    TollsAmount AS tolls_amount,
    TotalAmount AS total_amount
FROM source_data
WHERE PassengerCount > 0
  AND TripDistanceMiles > 0