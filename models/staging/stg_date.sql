WITH source_data AS (
    SELECT * 
    FROM {{ source('fabric_raw', 'Date') }}
)

SELECT
    DateID AS date_id,
    CAST(Date AS DATE) AS full_date,
    Year AS year_number,
    YearName AS year_name,
    Quarter AS quarter_number,
    QuarterName AS quarter_name,
    Month AS month_number,
    MonthName AS month_name,
    MonthYear AS month_year,
    DayOfMonth AS day_of_month,
    DayName AS day_name,
    IsWeekday AS is_weekday,
    IsHolidayUSA AS is_holiday_usa,
    FirstDayOfMonth AS first_day_of_month,
    LastDayOfMonth AS last_day_of_month
FROM source_data