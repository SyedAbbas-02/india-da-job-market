-- Q3 (part 2): Where annual salary is disclosed, how does it vary by city?
-- Salary measure: midpoint of the posted range (salary_mid_lpa); min-only and max-only rows have no midpoint and are left out.
-- Pool "clean": salary_usable_clean = 1 (not an internship stipend, not flagged as outlier),
--   minus job 147 (a 5 to 17 LPA range that the outlier rule missed; same kind as job 214).
-- Pool "usable_all": salary_usable = 1, outliers included, to show how much the outliers move the median.
-- MySQL has no MEDIAN(), so the median is the average of the one or two middle rows (window functions).
-- Counts are 3 to 11 per city: report median with n and min/max, and make no claims about differences.
USE job_market;

WITH pool AS (
    SELECT 'clean' AS pool, primary_city, salary_mid_lpa AS mid
    FROM analysis_jobs
    WHERE salary_usable_clean = 1 AND salary_mid_lpa IS NOT NULL AND job_id <> 147
    UNION ALL
    SELECT 'usable_all', primary_city, salary_mid_lpa
    FROM analysis_jobs
    WHERE salary_usable = 1 AND salary_mid_lpa IS NOT NULL
),
ranked AS (
    SELECT pool, primary_city, mid,
           ROW_NUMBER() OVER (PARTITION BY pool, primary_city ORDER BY mid) AS rn,
           COUNT(*)     OVER (PARTITION BY pool, primary_city)               AS cnt
    FROM pool
),
med AS (
    SELECT pool, primary_city, AVG(mid) AS median_mid
    FROM ranked
    WHERE rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2))
    GROUP BY pool, primary_city
),
stats AS (
    SELECT pool, primary_city, COUNT(*) AS n, MIN(mid) AS lowest, MAX(mid) AS highest
    FROM pool
    GROUP BY pool, primary_city
)
SELECT s.pool, s.primary_city, s.n,
       ROUND(m.median_mid, 2) AS median_mid_lpa,
       s.lowest, s.highest
FROM stats s
JOIN med m ON m.pool = s.pool AND m.primary_city = s.primary_city
ORDER BY s.pool, m.median_mid DESC;