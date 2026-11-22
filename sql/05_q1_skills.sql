-- Q1: Which skills do Data Analyst postings ask for, and how does it differ between the
-- fresher band (description minimum 0-1 years) and the experienced band (2+ years)?
-- Base: q1_base = 1 within the analysis set. Postings with no stated minimum ("unknown")
-- are in the overall column but in neither band.
-- A skill counts only when the description states it (desc_level = 'stated'); preferred,
-- keyskills blocks and portal-tag-only mentions are excluded.
-- Percentages use the band size as denominator; always read them with the counts.
USE job_market;

WITH base AS (
    SELECT job_id, exp_band_desc
    FROM analysis_jobs
    WHERE q1_base = 1
),
base_n AS (
    SELECT COUNT(*)                               AS n_all,
           SUM(exp_band_desc = 'fresher (0-1)')   AS n_fresh,
           SUM(exp_band_desc = 'experienced (2+)') AS n_exp
    FROM base
),
skill_counts AS (
    SELECT s.skill, s.skill_type,
           COUNT(DISTINCT b.job_id) AS n_all,
           COUNT(DISTINCT CASE WHEN b.exp_band_desc = 'fresher (0-1)'    THEN b.job_id END) AS n_fresh,
           COUNT(DISTINCT CASE WHEN b.exp_band_desc = 'experienced (2+)' THEN b.job_id END) AS n_exp
    FROM base b
    JOIN job_skills js ON js.job_id = b.job_id AND js.desc_level = 'stated'
    JOIN skills s      ON s.skill_id = js.skill_id
    GROUP BY s.skill, s.skill_type
)
SELECT sc.skill, sc.skill_type,
       RANK() OVER (ORDER BY sc.n_all DESC)      AS rnk,
       sc.n_all,   ROUND(100 * sc.n_all   / bn.n_all,   1) AS pct_all,
       sc.n_fresh, ROUND(100 * sc.n_fresh / bn.n_fresh, 1) AS pct_fresh,
       sc.n_exp,   ROUND(100 * sc.n_exp   / bn.n_exp,   1) AS pct_exp,
       bn.n_all AS base_all, bn.n_fresh AS base_fresh, bn.n_exp AS base_exp
FROM skill_counts sc
CROSS JOIN base_n bn
ORDER BY rnk, sc.skill
LIMIT 15;
