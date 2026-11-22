-- Q3 check: look at every usable salary, outliers first, before computing any medians.
-- Shows the outlier reason next to experience and title so each flag can be judged by hand.
USE job_market;

SELECT job_id, source, primary_city, job_title,
       salary_portal,
       salary_min_lpa, salary_max_lpa, salary_mid_lpa,
       salary_outlier, salary_outlier_reason,
       exp_min, experience_portal,
       is_internship, is_contract
FROM analysis_jobs
WHERE salary_usable = 1
ORDER BY salary_outlier DESC, salary_mid_lpa DESC;
