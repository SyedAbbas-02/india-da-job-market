-- Q5: Which titles (MIS, Business Analyst, Operations) ask for the same skills as Data Analyst roles, measured as the share of the top 10 Data Analyst skills each title states? Reference group = q1_base (102 rows), analysis set only, "Other" titles excluded.
USE job_market;

WITH top10 AS (
  SELECT js.skill_id
  FROM analysis_jobs j
  JOIN job_skills js ON js.job_id = j.job_id
  JOIN skills s      ON s.skill_id = js.skill_id
  WHERE j.q1_base = 1 AND js.desc_level = 'stated'
  GROUP BY s.skill_id, s.skill
  ORDER BY COUNT(*) DESC, s.skill
  LIMIT 10
),
top8 AS (
  SELECT js.skill_id
  FROM analysis_jobs j
  JOIN job_skills js ON js.job_id = j.job_id
  JOIN skills s      ON s.skill_id = js.skill_id
  WHERE j.q1_base = 1 AND js.desc_level = 'stated'
  GROUP BY s.skill_id, s.skill
  ORDER BY COUNT(*) DESC, s.skill
  LIMIT 8
),
grp AS (
  SELECT job_id, source, thin_description, borderline,
    CASE
      WHEN q1_base = 1 THEN '1 Data Analyst (q1_base)'
      WHEN job_title REGEXP '(^|[^A-Za-z])MIS([^A-Za-z]|$)' THEN '2 MIS'
      WHEN job_title LIKE '%Business Analy%' OR job_title = 'BA' THEN '3 Business Analyst'
      WHEN job_title LIKE '%Operation%' THEN '4 Operations'
    END AS title_group
  FROM analysis_jobs
  WHERE in_analysis_set = 1
    AND (q1_base = 1 OR da_title = 0)
),
per_job AS (
  SELECT g.job_id, g.title_group, g.thin_description, g.borderline,
         COUNT(DISTINCT x10.skill_id) AS k10,
         COUNT(DISTINCT x8.skill_id)  AS k8
  FROM grp g
  LEFT JOIN (SELECT js.job_id, js.skill_id
             FROM job_skills js JOIN top10 t ON t.skill_id = js.skill_id
             WHERE js.desc_level = 'stated') x10 ON x10.job_id = g.job_id
  LEFT JOIN (SELECT js.job_id, js.skill_id
             FROM job_skills js JOIN top8 t ON t.skill_id = js.skill_id
             WHERE js.desc_level = 'stated') x8 ON x8.job_id = g.job_id
  WHERE g.title_group IS NOT NULL
  GROUP BY g.job_id, g.title_group, g.thin_description, g.borderline
)
SELECT
  title_group,
  COUNT(*)                                                   AS n_all,
  ROUND(100 * AVG(k10) / 10, 1)                              AS pct_top10_all,
  ROUND(100 * AVG(k8) / 8, 1)                                AS pct_top8_all,
  SUM(thin_description = 0)                                  AS n_no_thin,
  ROUND(100 * AVG(CASE WHEN thin_description = 0 THEN k10 END) / 10, 1) AS pct_top10_no_thin,
  SUM(thin_description = 0 AND borderline = 0)               AS n_clean,
  ROUND(100 * AVG(CASE WHEN thin_description = 0 AND borderline = 0 THEN k10 END) / 10, 1) AS pct_top10_clean,
  SUM(k10 = 0)                                               AS rows_with_zero
FROM per_job
GROUP BY title_group
ORDER BY title_group;