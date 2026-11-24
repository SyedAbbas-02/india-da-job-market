-- Skill pairs: Which pairs of skills are stated together most often in Data Analyst postings (q1_base, analysis set), and how often does a posting asking for the first skill also ask for the second? Self-join on job_skills, stated mentions only.
USE job_market;

WITH base AS (
  SELECT js.job_id, js.skill_id
  FROM job_skills js
  JOIN analysis_jobs j ON j.job_id = js.job_id
  WHERE j.q1_base = 1 AND js.desc_level = 'stated'
),
cnt AS (
  SELECT skill_id, COUNT(*) AS n_skill FROM base GROUP BY skill_id
)
SELECT
  s1.skill AS skill_a,
  s2.skill AS skill_b,
  COUNT(*) AS rows_both,
  ROUND(100 * COUNT(*) / (SELECT COUNT(*) FROM analysis_jobs WHERE q1_base = 1), 1) AS pct_of_102,
  ROUND(100 * COUNT(*) / c1.n_skill, 1) AS pct_of_a_also_b,
  ROUND(100 * COUNT(*) / c2.n_skill, 1) AS pct_of_b_also_a
FROM base a
JOIN base b   ON a.job_id = b.job_id AND a.skill_id < b.skill_id
JOIN skills s1 ON s1.skill_id = a.skill_id
JOIN skills s2 ON s2.skill_id = b.skill_id
JOIN cnt c1    ON c1.skill_id = a.skill_id
JOIN cnt c2    ON c2.skill_id = b.skill_id
GROUP BY a.skill_id, b.skill_id, s1.skill, s2.skill, c1.n_skill, c2.n_skill
HAVING COUNT(*) >= 10
ORDER BY rows_both DESC
LIMIT 20;