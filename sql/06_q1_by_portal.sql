-- Q1 (portal split): do the main Data Analyst skills look the same on each portal?
-- Base: q1_base = 1 in the analysis set, grouped by source. Skill counted only when
-- desc_level = 'stated'. Read percentages with base_n; some portals have very few rows.
USE job_market;

WITH base AS (
    SELECT job_id, source FROM analysis_jobs WHERE q1_base = 1
),
bn AS (
    SELECT source, COUNT(*) AS base_n FROM base GROUP BY source
),
sc AS (
    SELECT s.skill, b.source, COUNT(DISTINCT b.job_id) AS n
    FROM base b
    JOIN job_skills js ON js.job_id = b.job_id AND js.desc_level = 'stated'
    JOIN skills s ON s.skill_id = js.skill_id
    GROUP BY s.skill, b.source
)
SELECT sc.skill, sc.source, sc.n, bn.base_n,
       ROUND(100 * sc.n / bn.base_n, 1) AS pct
FROM sc
JOIN bn ON bn.source = sc.source
WHERE sc.skill IN ('SQL','Excel','Power BI','Python','Tableau','Dashboards/visualization','Pivot tables')
ORDER BY sc.skill, sc.source;
