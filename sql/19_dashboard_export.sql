-- Phase 5 export: two flat tables for the Power BI dashboard (analysis set only, no description text, no company names).
USE job_market;

-- Table 1: one row per analysis-set posting.
-- title_group uses da_title (all Data Analyst-titled rows), not q1_base, so it is wider than the Q1 and Q5 reference group (102).
SELECT j.job_id, j.source, j.primary_city,
  CASE
    WHEN j.da_title = 1 THEN 'Data Analyst'
    WHEN j.job_title REGEXP '(^|[^A-Za-z])MIS([^A-Za-z]|$)' THEN 'MIS'
    WHEN j.job_title LIKE '%Business Analy%' OR j.job_title = 'BA' THEN 'Business Analyst'
    WHEN j.job_title LIKE '%Operation%' THEN 'Operations'
    ELSE 'Other'
  END AS title_group,
  j.q1_base, j.entry_title_any, j.entry_title_no_assoc,
  j.exp_min, j.exp_band_desc, j.exp_band_fallback,
  j.salary_usable_clean, j.salary_mid_lpa,
  j.is_internship, j.is_remote, j.is_old
FROM analysis_jobs j
WHERE j.in_analysis_set = 1
ORDER BY j.job_id;

-- Table 2: one row per posting and stated skill.
SELECT js.job_id, s.skill, s.skill_type
FROM job_skills js
JOIN skills s       ON s.skill_id = js.skill_id
JOIN analysis_jobs j ON j.job_id = js.job_id
WHERE j.in_analysis_set = 1 AND js.desc_level = 'stated'
ORDER BY js.job_id, s.skill;