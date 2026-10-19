WITH source_data AS (
    SELECT * 
    FROM {{ source('fabric_raw', 'Geography') }}
)

SELECT
    GeographyID AS geography_id,
    ZipCode AS zip_code,
    City AS city,
    County AS county,
    State AS state_code,
    Country AS country
FROM source_data