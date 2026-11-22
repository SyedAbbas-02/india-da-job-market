-- Q1 check: does the fresher vs experienced skill gap survive inside a single portal?
-- Only Indeed and LinkedIn have both bands. Counts are tiny (5 to 13 per cell): direction only.
USE job_market;

WITH base AS (
    SELECT job_id, source, exp_band_desc
    FROM analysis_jobs
    WHERE q1_base = 1
      AND source IN ('Indeed', 'LinkedIn')
      AND exp_band_desc IN ('fresher (0-1)', 'experienced (2+)')
),
bn AS (
    SELECT source, exp_band_desc, COUNT(*) AS base_n
    FROM base GROUP BY source, exp_band_desc
)
SELECT s.skill, b.source, b.exp_band_desc,
       COUNT(DISTINCT b.job_id) AS n,
       bn.base_n
FROM base b
JOIN bn ON bn.source = b.source AND bn.exp_band_desc = b.exp_band_desc
JOIN job_skills js ON js.job_id = b.job_id AND js.desc_level = 'stated'
JOIN skills s ON s.skill_id = js.skill_id
WHERE s.skill IN ('SQL','Excel','Python','Power BI','Pivot tables')
GROUP BY s.skill, b.source, b.exp_band_desc, bn.base_n
ORDER BY s.skill, b.source, b.exp_band_desc;
