-- Q4: What share of entry-level titled postings still ask for 1+ years of experience in the description,
-- and how often does that differ from the portal's experience field?
-- Base: analysis set. Entry-level title rule from questions.md in three versions:
--   any = entry_title_any; no_assoc = entry_title_no_assoc; strict = no_assoc and not an internship.
-- exp_min comes from the description only. NULL = no number stated: counted separately, never as 0,
-- so "asks 1+ years" is a floor, not a rate for all entry-level postings.
-- exp_portal_min is the portal minimum (Naukri range, or Fresher on Indeed and Foundit; LinkedIn has none).
-- "differs" = both values present and they are 1 or more years apart.
USE job_market;

-- Part A: summary by title rule
SELECT def,
       COUNT(*)                                            AS n_rows,
       SUM(exp_min IS NOT NULL)                            AS n_desc_min_stated,
       SUM(exp_min IS NULL)                                AS n_no_number,
       SUM(exp_min >= 1)                                   AS n_asks_1plus,
       SUM(exp_min >= 2)                                   AS n_asks_2plus,
       SUM(exp_portal_min IS NOT NULL)                     AS n_portal_min,
       SUM(exp_min IS NOT NULL AND exp_portal_min IS NOT NULL)                                AS n_both,
       SUM(exp_min IS NOT NULL AND exp_portal_min IS NOT NULL AND ABS(exp_min - exp_portal_min) >= 1) AS n_differ,
       SUM(exp_min IS NOT NULL AND exp_portal_min IS NOT NULL AND exp_min - exp_portal_min >= 1)      AS n_desc_higher
FROM (
    SELECT 'any' AS def, exp_min, exp_portal_min FROM analysis_jobs WHERE entry_title_any = 1
    UNION ALL
    SELECT 'no_assoc', exp_min, exp_portal_min FROM analysis_jobs WHERE entry_title_no_assoc = 1
    UNION ALL
    SELECT 'strict', exp_min, exp_portal_min FROM analysis_jobs
    WHERE entry_title_no_assoc = 1 AND is_internship = 0
) t
GROUP BY def
ORDER BY FIELD(def, 'any', 'no_assoc', 'strict');

-- Part B: the same by portal (title rule: any), to show where the answer changes
SELECT source,
       COUNT(*)                   AS n_rows,
       SUM(exp_min IS NOT NULL)   AS n_desc_min_stated,
       SUM(exp_min IS NULL)       AS n_no_number,
       SUM(exp_min >= 1)          AS n_asks_1plus,
       SUM(exp_min >= 2)          AS n_asks_2plus
FROM analysis_jobs
WHERE entry_title_any = 1
GROUP BY source
ORDER BY source;

-- Part C: every entry-level (any) posting that asks 1+ years, to check by hand
SELECT job_id, source, job_title, exp_min, exp_max, exp_portal_min, experience_portal,
       entry_title_assoc, is_internship
FROM analysis_jobs
WHERE entry_title_any = 1 AND exp_min >= 1
ORDER BY exp_min DESC, source, job_id;