{% set payment_types = ['Credit Card', 'Cash', 'No Charge'] %}

WITH trips AS (
    SELECT * 
    FROM {{ ref('fct_trips') }}
)

SELECT
    date_id,
    COUNT(*) AS total_trips,
    ROUND(SUM(total_amount), 2) AS total_gross_revenue,

    -- Dynamic Jinja Pivot with chained filters: lower + replace space with underscore
    {% for pt in payment_types %}
    ROUND(SUM(CASE WHEN payment_type = '{{ pt }}' THEN total_amount ELSE 0 END), 2) AS {{ pt | lower | replace(' ', '_') }}_amount{% if not loop.last %},{% endif %}
    {% endfor %}

FROM trips
GROUP BY date_id