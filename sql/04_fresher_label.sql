-- Q4 (part): how often does a portal "Fresher" label ask for experience in the description?
-- Shown for all 300 collected rows (in_analysis_set = 0 are duplicates or off-target) and the analysis set (= 1).
-- desc_min_stated counts rows where the description gives a minimum number of years; some rows ask for
-- experience without a number, so this undercounts.
USE job_market;

SELECT source, in_analysis_set,
       COUNT(*)                AS fresher_labelled,
       SUM(exp_min IS NOT NULL) AS desc_min_stated,
       SUM(exp_min >= 1)        AS desc_asks_1plus,
       SUM(exp_min >= 2)        AS desc_asks_2plus,
       MAX(exp_min)             AS max_min_years
FROM jobs
WHERE experience_portal = 'Fresher'
GROUP BY source, in_analysis_set
ORDER BY source, in_analysis_set;

SELECT job_id, source, in_analysis_set, job_title, exp_min, exp_max
FROM jobs
WHERE experience_portal = 'Fresher' AND exp_min >= 1
ORDER BY exp_min DESC, source, job_id;
