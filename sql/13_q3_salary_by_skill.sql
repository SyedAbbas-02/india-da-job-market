-- Q3 (part 3): Where annual salary is disclosed, how does it vary by skill?
-- Pool: same 37 clean rows with a midpoint as in 12_q3_salary_by_city.sql (clean, midpoint present, job 147 out).
-- A skill counts as present only when the description states it (desc_level = 'stated').
-- "Not stated" mixes jobs that do not need the skill with thin descriptions that say nothing, so
-- the comparison is a direction check only. Median = average of the middle row(s); n shown for every cell.
USE job_market;

WITH pool AS (
    SELECT job_id, salary_mid_lpa AS mid
    FROM analysis_jobs
    WHERE salary_usable_clean = 1 AND salary_mid_lpa IS NOT NULL AND job_id <> 147
),
sk AS (
    SELECT skill_id, skill FROM skills
    WHERE skill IN ('SQL','Excel','Power BI','Python','Tableau')
),
grid AS (
    SELECT p.job_id, p.mid, sk.skill,
           CASE WHEN EXISTS (SELECT 1 FROM job_skills js
                             WHERE js.job_id = p.job_id AND js.skill_id = sk.skill_id
                               AND js.desc_level = 'stated')
                THEN 'stated' ELSE 'not stated' END AS has_skill
    FROM pool p CROSS JOIN sk
),
ranked AS (
    SELECT skill, has_skill, mid,
           ROW_NUMBER() OVER (PARTITION BY skill, has_skill ORDER BY mid) AS rn,
           COUNT(*)     OVER (PARTITION BY skill, has_skill)              AS cnt
    FROM grid
),
med AS (
    SELECT skill, has_skill, AVG(mid) AS median_mid
    FROM ranked
    WHERE rn IN (FLOOR((cnt + 1) / 2), CEIL((cnt + 1) / 2))
    GROUP BY skill, has_skill
)
SELECT g.skill, g.has_skill, COUNT(*) AS n,
       ROUND(m.median_mid, 2) AS median_mid_lpa,
       MIN(g.mid) AS lowest, MAX(g.mid) AS highest
FROM grid g
JOIN med m ON m.skill = g.skill AND m.has_skill = g.has_skill
GROUP BY g.skill, g.has_skill, m.median_mid
ORDER BY g.skill, g.has_skill;