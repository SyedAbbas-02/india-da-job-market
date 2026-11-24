-- Q5 detail: For each of the top 10 Data Analyst skills, what share of Data Analyst, MIS, Business Analyst and Operations postings state it? Shows which skills explain the gap in file 15.
USE job_market;

WITH top10 AS (
  SELECT s.skill_id, s.skill, COUNT(*) AS rows_asking
  FROM analysis_jobs j
  JOIN job_skills js ON js.job_id = j.job_id
  JOIN skills s      ON s.skill_id = js.skill_id
  WHERE j.q1_base = 1 AND js.desc_level = 'stated'
  GROUP BY s.skill_id, s.skill
  ORDER BY rows_asking DESC, s.skill
  LIMIT 10
),
grp AS (
  SELECT job_id,
    CASE
      WHEN q1_base = 1 THEN 'DA'
      WHEN job_title REGEXP '(^|[^A-Za-z])MIS([^A-Za-z]|$)' THEN 'MIS'
      WHEN job_title LIKE '%Business Analy%' OR job_title = 'BA' THEN 'BA'
      WHEN job_title LIKE '%Operation%' THEN 'OPS'
    END AS title_group
  FROM analysis_jobs
  WHERE in_analysis_set = 1 AND (q1_base = 1 OR da_title = 0)
)
SELECT
  t.skill,
  ROUND(100 * SUM(g.title_group = 'DA'  AND js.job_id IS NOT NULL) / SUM(g.title_group = 'DA'), 1)  AS da_pct,
  ROUND(100 * SUM(g.title_group = 'MIS' AND js.job_id IS NOT NULL) / SUM(g.title_group = 'MIS'), 1) AS mis_pct,
  SUM(g.title_group = 'MIS' AND js.job_id IS NOT NULL)  AS mis_n,
  ROUND(100 * SUM(g.title_group = 'BA'  AND js.job_id IS NOT NULL) / SUM(g.title_group = 'BA'), 1)  AS ba_pct,
  SUM(g.title_group = 'BA'  AND js.job_id IS NOT NULL)  AS ba_n,
  ROUND(100 * SUM(g.title_group = 'OPS' AND js.job_id IS NOT NULL) / SUM(g.title_group = 'OPS'), 1) AS ops_pct,
  SUM(g.title_group = 'OPS' AND js.job_id IS NOT NULL)  AS ops_n
FROM top10 t
CROSS JOIN grp g
LEFT JOIN job_skills js
  ON js.job_id = g.job_id AND js.skill_id = t.skill_id AND js.desc_level = 'stated'
WHERE g.title_group IS NOT NULL
GROUP BY t.skill_id, t.skill, t.rows_asking
ORDER BY t.rows_asking DESC, t.skill;