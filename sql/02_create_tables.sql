-- Creates the three tables of the project database: jobs, skills, job_skills.
-- jobs: one row per collected posting (300 rows), structured fields and flags only (no description text).
-- skills: the 45-skill vocabulary (tools and concepts).
-- job_skills: one row per posting and skill, with where the skill was found.
-- WARNING: drops tables with these names in job_market before creating them.
USE job_market;

DROP TABLE IF EXISTS job_skills;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS jobs;

CREATE TABLE jobs (
  job_id INT NOT NULL PRIMARY KEY,
  source VARCHAR(10) NOT NULL,
  job_title VARCHAR(255),
  company VARCHAR(255),
  city VARCHAR(255),
  search_city VARCHAR(20),
  primary_city VARCHAR(20),
  city_flag VARCHAR(40),
  work_mode_clean VARCHAR(20),
  posted_ago VARCHAR(30),
  age_days INT,
  age_source VARCHAR(12),
  is_old TINYINT(1),
  is_reposted_label TINYINT(1),
  refreshed_label_conflict TINYINT(1),
  experience_portal VARCHAR(30),
  exp_min DECIMAL(5,2),
  exp_max DECIMAL(5,2),
  exp_form VARCHAR(20),
  exp_source VARCHAR(20),
  exp_phrases_disagree TINYINT(1),
  exp_lost_dash TINYINT(1),
  exp_portal_min DECIMAL(5,2),
  exp_portal_max DECIMAL(5,2),
  exp_min_fallback DECIMAL(5,2),
  exp_fallback_source VARCHAR(12),
  exp_conflict_flag TINYINT(1),
  desc_min_above_portal_max TINYINT(1),
  exp_band_desc VARCHAR(20),
  exp_band_fallback VARCHAR(20),
  exp_entry_wording TINYINT(1),
  entry_title_words TINYINT(1),
  entry_title_assoc TINYINT(1),
  entry_title_level TINYINT(1),
  entry_title_any TINYINT(1),
  entry_title_no_assoc TINYINT(1),
  entry_title_mixed TINYINT(1),
  da_title TINYINT(1),
  q1_base TINYINT(1),
  q1_assoc_sens TINYINT(1),
  salary_portal VARCHAR(60),
  salary_min_lpa DECIMAL(8,3),
  salary_max_lpa DECIMAL(8,3),
  salary_mid_lpa DECIMAL(8,3),
  salary_form VARCHAR(25),
  salary_source VARCHAR(12),
  salary_outlier TINYINT(1),
  salary_outlier_reason VARCHAR(60),
  salary_usable TINYINT(1),
  salary_usable_clean TINYINT(1),
  edu_level_desc VARCHAR(20),
  edu_portal_class VARCHAR(20),
  edu_conflict_flag TINYINT(1),
  edu_manual TINYINT(1),
  is_internship TINYINT(1),
  is_remote TINYINT(1),
  is_contract TINYINT(1),
  has_bond_or_service_agreement TINYINT(1),
  eligibility_restricted TINYINT(1),
  eligibility_reason VARCHAR(100),
  is_staffing_or_aggregator TINYINT(1),
  staffing_reason VARCHAR(100),
  off_target TINYINT(1),
  off_target_reason VARCHAR(60),
  borderline TINYINT(1),
  borderline_reason VARCHAR(60),
  thin_description TINYINT(1),
  desc_len INT,
  is_repost_or_dup TINYINT(1),
  dup_group INT,
  dup_kept_job_id INT,
  dup_confidence VARCHAR(12),
  dup_raw_cities VARCHAR(1000),
  dup_sources VARCHAR(80),
  excel_advanced TINYINT(1),
  in_analysis_set TINYINT(1),
  INDEX idx_analysis (in_analysis_set),
  INDEX idx_city (primary_city),
  INDEX idx_source (source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE skills (
  skill_id INT NOT NULL PRIMARY KEY,
  skill VARCHAR(40) NOT NULL UNIQUE,
  skill_type VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE job_skills (
  job_id INT NOT NULL,
  skill_id INT NOT NULL,
  desc_level VARCHAR(12) NULL,
  desc_mentions INT NOT NULL DEFAULT 0,
  in_portal_tags TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (job_id, skill_id),
  INDEX idx_skill (skill_id),
  FOREIGN KEY (job_id) REFERENCES jobs (job_id),
  FOREIGN KEY (skill_id) REFERENCES skills (skill_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
