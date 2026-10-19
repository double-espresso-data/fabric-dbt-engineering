SELECT
    date_id,
    full_date,
    year_number,
    year_name,
    quarter_number,
    quarter_name,
    month_number,
    month_name,
    month_year,
    day_of_month,
    day_name,
    is_weekday,
    is_holiday_usa,
    first_day_of_month,
    last_day_of_month
FROM {{ ref('stg_date') }}