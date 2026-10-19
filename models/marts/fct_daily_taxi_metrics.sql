/*
{{ config(materialized='table') }}: Tells dbt to build a real physical table in Fabric 
(fast for reporting and Power BI).
{{ ref('stg_trips') }}: It automatically depends on your clean staging view.
*/


{{ config(materialized='table') }}

WITH trips AS (
    SELECT * 
    FROM {{ ref('stg_trips') }}
)
SELECT
    date_id,
    COUNT(*) AS total_trips,
    SUM(passenger_count) AS total_passengers,
    ROUND(SUM(trip_distance_miles), 2) AS total_distance_miles,
    ROUND(AVG(trip_distance_miles), 2) AS avg_distance_miles,
    ROUND(SUM(fare_amount), 2) AS total_fare_revenue,
    ROUND(SUM(tip_amount), 2) AS total_tips,
    ROUND(SUM(total_amount), 2) AS total_gross_revenue,
    ROUND(AVG(fare_amount), 2) AS avg_fare_per_trip
FROM trips
GROUP BY date_id