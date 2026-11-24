-- Q5 portal check: Does the title-group gap in top-10 skill share and SQL hold within each portal, or is it a portal effect? Same groups and top 10 as files 15 and 16.
USE job_market;

WITH top10 AS (
  SELECT s.skill_id
  FROM analysis_jobs j
  JOIN job_skills js ON js.job_id = j.job_id
  JOIN skills s      ON s.skill_id = js.skill_id
  WHERE j.q1_base = 1 AND js.desc_level = 'stated'
  GROUP BY s.skill_id, s.skill
  ORDER BY COUNT(*) DESC, s.skill
  LIMIT 10
),
grp AS (
  SELECT job_id, source,
    CASE
      WHEN q1_base = 1 THEN '1 DA'
      WHEN job_title REGEXP '(^|[^A-Za-z])MIS([^A-Za-z]|$)' THEN '2 MIS'
      WHEN job_title LIKE '%Business Analy%' OR job_title = 'BA' THEN '3 BA'
      WHEN job_title LIKE '%Operation%' THEN '4 OPS'
    END AS title_group
  FROM analysis_jobs
  WHERE in_analysis_set = 1 AND (q1_base = 1 OR da_title = 0)
),
per_job AS (
  SELECT g.job_id, g.title_group, g.source,
         COUNT(DISTINCT x.skill_id) AS k10,
         COALESCE(MAX(x.skill_id = (SELECT skill_id FROM skills WHERE skill = 'SQL')), 0) AS has_sql
  FROM grp g
  LEFT JOIN (SELECT js.job_id, js.skill_id
             FROM job_skills js JOIN top10 t ON t.skill_id = js.skill_id
             WHERE js.desc_level = 'stated') x ON x.job_id = g.job_id
  WHERE g.title_group IS NOT NULL
  GROUP BY g.job_id, g.title_group, g.source
)
SELECT title_group, source,
       COUNT(*)                        AS n,
       ROUND(100 * AVG(k10) / 10, 1)   AS pct_top10,
       SUM(has_sql)                    AS sql_n,
       ROUND(100 * AVG(has_sql), 1)    AS sql_pct
FROM per_job
GROUP BY title_group, source
ORDER BY title_group, source;