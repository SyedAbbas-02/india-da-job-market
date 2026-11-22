-- Q1 checks: (a) which portals the fresher and experienced bands come from;
-- (b) on Naukri, is SQL missing from descriptions but present in portal tags?
USE job_market;

-- (a) experience band by portal (Data Analyst base)
SELECT source, exp_band_desc, COUNT(*) AS n
FROM analysis_jobs
WHERE q1_base = 1
GROUP BY source, exp_band_desc
ORDER BY source, exp_band_desc;

-- (b) Naukri Data Analyst rows that have an SQL row in job_skills, by how it was found
-- (Naukri rows with no SQL row at all are not listed: 30 minus the sum of n)
SELECT COALESCE(NULLIF(js.desc_level, ''), 'none') AS desc_level,
       js.in_portal_tags,
       COUNT(*) AS n
FROM analysis_jobs a
JOIN job_skills js ON js.job_id = a.job_id
JOIN skills s ON s.skill_id = js.skill_id
WHERE a.q1_base = 1 AND a.source = 'Naukri' AND s.skill = 'SQL'
GROUP BY COALESCE(NULLIF(js.desc_level, ''), 'none'), js.in_portal_tags
ORDER BY desc_level, js.in_portal_tags;
