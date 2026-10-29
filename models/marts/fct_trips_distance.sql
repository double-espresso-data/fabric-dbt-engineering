select 
date_id,
medallion_id,
hackney_license_id,
trip_distance_miles,
{{ categorize_range('trip_distance_miles', short_limit = 3.0, medium_limit = 8.0) }} 
as distance_category
FROM
{{ ref('stg_trips') }}