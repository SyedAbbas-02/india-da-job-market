-- Base view for every Phase 4 query: the analysis set (not off-target, not a duplicate).
USE job_market;
CREATE OR REPLACE VIEW analysis_jobs AS
SELECT * FROM jobs WHERE in_analysis_set = 1;
