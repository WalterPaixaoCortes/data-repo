
WITH RECURSIVE dates AS (
  SELECT CURRENT_DATE - INTERVAL '5 years' AS date
  UNION ALL
  SELECT date + INTERVAL '1 day'
  FROM dates
  WHERE date < CURRENT_DATE + INTERVAL '5 years'
),
time_dimension AS (
  SELECT
    TO_CHAR(date, 'YYYYMMDD')::INTEGER AS date_key,
    date AS full_date,
    EXTRACT(YEAR FROM date)::INTEGER AS year,
    EXTRACT(MONTH FROM date)::INTEGER AS month,
    EXTRACT(DAY FROM date)::INTEGER AS day,
    EXTRACT(DOW FROM date)::INTEGER AS day_of_week,
    EXTRACT(DOY FROM date)::INTEGER AS day_of_year,
    EXTRACT(QUARTER FROM date)::INTEGER AS quarter,
    TO_CHAR(date, 'Month') AS month_name,
    TO_CHAR(date, 'Mon') AS month_name_short,
    TO_CHAR(date, 'Day') AS day_name,
    TO_CHAR(date, 'Dy') AS day_name_short,
    CASE 
      WHEN EXTRACT(MONTH FROM date) >= 2 THEN EXTRACT(YEAR FROM date)
      ELSE EXTRACT(YEAR FROM date) - 1
    END AS fiscal_year,
    CASE 
      WHEN EXTRACT(MONTH FROM date) >= 2 THEN EXTRACT(MONTH FROM date) - 1
      ELSE EXTRACT(MONTH FROM date) + 11
    END AS fiscal_month,
    CASE 
      WHEN EXTRACT(MONTH FROM date) >= 2 
      THEN CEIL((EXTRACT(MONTH FROM date) - 1) / 3.0)
      ELSE CEIL((EXTRACT(MONTH FROM date) + 11) / 3.0)
    END AS fiscal_quarter,
    CASE
      WHEN EXTRACT(ISODOW FROM date) IN (6, 7) THEN TRUE
      ELSE FALSE
    END AS is_weekend,
    CASE
      WHEN EXTRACT(MONTH FROM date) = 1 AND EXTRACT(DAY FROM date) = 1 THEN TRUE
      ELSE FALSE
    END AS is_new_year,
    CASE
      WHEN EXTRACT(MONTH FROM date) = 2 AND EXTRACT(DAY FROM date) = 1 THEN TRUE
      ELSE FALSE
    END AS is_fiscal_year_start,
    EXTRACT(EPOCH FROM date)::INTEGER as epoch,
    TO_CHAR(date, 'IYYY-IW')::VARCHAR AS iso_week,
    EXTRACT(WEEK FROM date)::INTEGER AS week_of_year,
    CASE
      WHEN EXTRACT(MONTH FROM date) IN (3,4,5) THEN 'Spring'
      WHEN EXTRACT(MONTH FROM date) IN (6,7,8) THEN 'Summer'
      WHEN EXTRACT(MONTH FROM date) IN (9,10,11) THEN 'Fall'
      ELSE 'Winter'
    END AS season
  FROM dates
)
SELECT *
FROM time_dimension
ORDER BY date_key
