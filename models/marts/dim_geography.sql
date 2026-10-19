SELECT
    geography_id,
    zip_code,
    city,
    county,
    state_code,
    country
FROM {{ ref('stg_geography') }}