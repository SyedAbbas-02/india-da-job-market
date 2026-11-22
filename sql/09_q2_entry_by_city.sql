-- Q2: Which cities have the highest share of entry-level roles, and how does the title mix differ?
-- Base: analysis set, six main cities (primary_city); the 1 "Other" and 1 "Unknown" row are left out.
-- Quotas were fixed per city, so this says nothing about city size, only about the mix in each sample.
-- Entry-level uses the title rule from questions.md in three versions:
--   any = entry_title_any (includes Associate); no_assoc = entry_title_no_assoc;
--   strict = no_assoc and not an internship.
-- Counts are small (about 34 to 55 rows per city); read counts next to percentages.
USE job_market;

-- Part A: entry-level share by city
SELECT primary_city,
       COUNT(*)                                         AS n_rows,
       SUM(entry_title_any = 1)                         AS n_any,
       ROUND(100 * SUM(entry_title_any = 1) / COUNT(*), 1)       AS pct_any,
       SUM(entry_title_no_assoc = 1)                    AS n_no_assoc,
       ROUND(100 * SUM(entry_title_no_assoc = 1) / COUNT(*), 1)  AS pct_no_assoc,
       SUM(entry_title_no_assoc = 1 AND is_internship = 0)       AS n_strict,
       ROUND(100 * SUM(entry_title_no_assoc = 1 AND is_internship = 0) / COUNT(*), 1) AS pct_strict
FROM analysis_jobs
WHERE primary_city IN ('Bengaluru','Chennai','Delhi/NCR','Hyderabad','Mumbai','Pune')
GROUP BY primary_city
ORDER BY pct_any DESC;

-- Part B: title mix by city (title group derived from job_title; check the Other bucket)
SELECT primary_city,
       CASE
         WHEN da_title = 1 THEN 'Data Analyst'
         WHEN job_title REGEXP '(^|[^a-z])MIS([^a-z]|$)' THEN 'MIS'
         WHEN job_title LIKE '%business analy%' OR job_title = 'BA' THEN 'Business Analyst'
         WHEN job_title LIKE '%operations%' THEN 'Operations'
         ELSE 'Other'
       END AS title_group,
       COUNT(*) AS n
FROM analysis_jobs
WHERE primary_city IN ('Bengaluru','Chennai','Delhi/NCR','Hyderabad','Mumbai','Pune')
GROUP BY primary_city, title_group
ORDER BY primary_city, n DESC;

-- Part C: what falls in Other (to check the grouping)
SELECT job_id, primary_city, job_title
FROM analysis_jobs
WHERE primary_city IN ('Bengaluru','Chennai','Delhi/NCR','Hyderabad','Mumbai','Pune')
  AND da_title <> 1
  AND job_title <> 'BA'
  AND NOT job_title REGEXP '(^|[^a-z])MIS([^a-z]|$)'
  AND job_title NOT LIKE '%business analy%'
  AND job_title NOT LIKE '%operations%'
ORDER BY primary_city, job_id;
