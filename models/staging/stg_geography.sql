{{ config(materialized='ephemeral') }}

SELECT
    GeographyID AS geography_id,
    City AS city,
    State AS state_code
FROM {{ source('taxi_raw', 'Geography') }}
