-- Q3 (part 1): What share of postings disclose salary, by portal?
-- Base: analysis set. Three levels, because "disclosed" can mean different things:
--   portal_shows = salary_portal holds a value other than a "not disclosed" placeholder
--   parsed       = a salary minimum or maximum exists (portal field or description, see salary_source)
--   usable       = salary_usable (annual salary, internship stipends excluded)
--   clean        = salary_usable_clean (usable and not an outlier)
-- Counts are small; read counts next to percentages.
USE job_market;

SELECT source,
       COUNT(*) AS n_rows,
       SUM(salary_portal NOT IN ('Not disclosed','Not mentioned','Confidential'))          AS portal_shows,
       ROUND(100 * SUM(salary_portal NOT IN ('Not disclosed','Not mentioned','Confidential')) / COUNT(*), 1) AS pct_portal_shows,
       SUM(salary_min_lpa IS NOT NULL OR salary_max_lpa IS NOT NULL)                       AS parsed,
       SUM(salary_usable = 1)                                                              AS usable,
       ROUND(100 * SUM(salary_usable = 1) / COUNT(*), 1)                                   AS pct_usable,
       SUM(salary_usable_clean = 1)                                                        AS clean,
       ROUND(100 * SUM(salary_usable_clean = 1) / COUNT(*), 1)                             AS pct_clean
FROM analysis_jobs
GROUP BY source
WITH ROLLUP;

-- What the placeholders and parsed forms look like (check the NOT IN list above is complete)
SELECT salary_source, salary_form, COUNT(*) AS n,
       SUM(salary_usable = 1) AS usable, SUM(salary_outlier = 1) AS outliers
FROM analysis_jobs
WHERE salary_min_lpa IS NOT NULL OR salary_max_lpa IS NOT NULL
GROUP BY salary_source, salary_form
ORDER BY n DESC;

SELECT salary_portal, COUNT(*) AS n
FROM analysis_jobs
WHERE salary_portal IN ('Not disclosed','Not mentioned','Confidential')
   OR salary_portal NOT REGEXP '[0-9]'
GROUP BY salary_portal
ORDER BY n DESC;
