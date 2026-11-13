# Cleaning log

Where things stand (end of step 11): 300 raw rows; 246 in the analysis set (not off_target and not a duplicate): Naukri 76, LinkedIn 65, Indeed 53, Foundit 52. Steps 12 onward (skills, education, MySQL tables) are not done yet. Open items are listed at the end.

## Step 1: Load and inspect (2026-11-14)

- Raw file: 300 rows x 17 columns, 300 unique job_ids, 300 unique URLs. Naukri 99, LinkedIn 80, Indeed 62, Foundit 59.
- 0 empty cells. Placeholders: salary Not disclosed 232 (77%), skills No tags 142, experience_portal Not mentioned 134, posted_ago Not mentioned 62 (all Indeed).
- 294 unique description_text values of 300: 6 rows share an identical description with another row. Step 5 later found 24 duplicate rows, so exact-text matching alone would have missed most duplicates.
- 83 distinct city spellings; to standardize.
- work_mode_portal has "Hybrid work" (1) and "Hybrid" (22); to merge.
- industry_type: 143 Not mentioned, 50 "Other", labels differ by portal; not merged.

## Step 2a: Short text columns (2026-11-14)

- Trimmed/collapsed whitespace, non-breaking spaces and zero-width characters: job_title 9 values changed, education 63 (line breaks between UG and PG), all other short text columns 0.
- Placeholder casing variants: 0 found.
- work_mode_clean created: "Hybrid work" (1) merged into "Hybrid"; Hybrid 23, On-site 56, Remote 13, Not mentioned 208. Original work_mode_portal kept.

## Step 2b: description_clean (2026-11-14)

- description_text kept unchanged; cleaned copy in description_clean.
- Mojibake fixed in 2 rows (job 200: curly apostrophes; job 292: broken dash). 0 left.
- Non-breaking hyphens replaced: 5 rows. Zero-width characters removed: 1 row. Citation markers like [1] removed: 1 row (job 214, per the collection notes; not printed). Repeated spaces collapsed: 8 rows.
- Leading/trailing whitespace stripped (blank lines at the end of some descriptions).
- Total rows where description_clean differs from description_text at this point: 28 of 300.
- Not done in this step: boilerplate (Step 3) and glued words from lost line breaks (still open, see Open items).

## Step 3: Boilerplate stripped from description_clean (2026-11-14)

- Cut from marker to end of text: LinkedIn "Requirements added by the job poster" 4 rows (110, 148, 158, 166; 549 chars); LinkedIn "Benefits found in job post" 4 rows (115, 124, 125, 152; 188 chars); "Powered by JazzHR" 1 row (136; 31 chars); Indeed "Application Question(s):" 1 row (228; 616 chars).
- Job 152 (benefits line) was not in the collection notes; found by the check.
- Job 253 matched "application questionnaire" but that is real text; not cut.
- Scraped company-metadata header (Company, Website, Business Type, Funding Stage, Salary Range) removed up to the "Job Description" line: 3 rows (111, 133, 147; 698 chars). The salary ranges in 111 and 147 are also in the portal field.
- Naukri/Foundit disclaimer plus the field block after it: 26 rows cut (Naukri 25, Foundit 1), 12,692 chars removed. No skill or experience text was found after the disclaimer in any row.
- Same Naukri field block (Role, Industry Type, Department, Employment Type, Role Category, Education, UG/PG) in rows without a disclaimer: 73 rows cut (all Naukri), 18,426 chars removed. Every Naukri row had a disclaimer or a field block; job 67 had both.
- Job 67: its "Role Category" block is the employer's own text (age, office timing, working days, education); left in place, to be read during extraction.
- Job 3 (pilot): the real text is one sentence ("freshers... data analyst... contact"), with the field block on the same line and no line break; cut with an inline rule. 337 to 125 chars. Kept, flagged thin, no skills.
- Not cut by keyword: "fraud" (11 rows, includes real fraud-analysis duties in jobs 258 and 275) and equal-opportunity paragraphs (36 rows). To be tested against skill extraction.
- Final description_clean length: min 125, median 2,428, max 16,635 chars.
- thin_description flag (under 500 chars): 20 rows (Naukri 16, Indeed 3, Foundit 1), 3 of them under 300 (jobs 3, 27, 102). Kept and flagged; skill results to be checked with and without them.

## Step 4a: is_internship (2026-11-14)

- Rule: title contains intern/internship, plus one description-based case. 15 rows flagged (LinkedIn 8, Indeed 3, Foundit 3, Naukri 1): jobs 118, 119, 130, 142, 143, 144, 159, 184, 215, 216, 224, 255, 264, 273, 39.
- Job 39 flagged by description ("Position: Business Analyst (Intern)", 3 months, then permanent); its title does not say intern.
- Job 97 ("Business Analyst- Intern/Freshers") NOT flagged: portal says Full Time, Permanent and the description never mentions an internship. Judgment call.
- Jobs 22, 38, 93, 227 mention "internship experience" as a requirement only; not flagged.
- Naukri Employment Type has no Internship value (92 Full Time Permanent, 4 Full-Time, 1 Full-Time., 1 Full Time Temporary/Contractual, 1 Part Time Temporary/Contractual).
- Flagged rows are excluded from the salary analysis (stipends).

## Step 4b: is_remote and is_contract (2026-11-14)

- is_remote: 19 rows = 13 where the portal says Remote (jobs 8, 27, 28, 32, 54, 94, 99, 118, 122, 141, 159, 169, 203) + 6 where the description says remote but the portal does not (77, 184, 255, 264, 277, 296).
- Portal and description disagree on work mode: 77 (portal Hybrid, description Remote), 184 (portal On-site, description Remote), 123 and 259 (portal Not mentioned, description hybrid). Portal value kept in work_mode_portal.
- Not flagged remote: 123, 259, 163, 213, 301 (hybrid or one WFH day); 216 and 224 ("Hybrid remote" is Indeed's wording for hybrid). Judgment call.
- Remote postings keep the search city; the city is not meaningful for them (203, 277, 296 and others).
- is_contract: 3 rows at this step: 20 and 54 (Naukri Employment Type Temporary/Contractual), 208 (contract basis, third-party payroll). Corrected to 4 rows in step 4d.
- Job 233 lists "Contract / Freelance" among options only; not flagged (it is an excluded trainer role anyway).
- "Contract Type : Permanent" (82, 170, 293) and benefits or legal text using the word "contract" are not contract roles.

## Step 4c: bond, eligibility, staffing flags (2026-11-14)

- Keyword searches produce many false hits (equal-opportunity paragraphs mentioning persons with disabilities, "we bond beyond work", "our clients"), so every flagged row was read in context and the reason is stored (eligibility_reason, staffing_reason).
- has_bond_or_service_agreement: 3 rows: 61 (1-year commitment), 91 (2-year agreement), 93 (2.5-year agreement). Job 91 was missed by the first keyword pass (spacing around the hyphen in "2 - year agreement"); job 61 was found (the collection notes mention "bond" only as non-job text).
- eligibility_restricted: 11 rows: 38, 74, 88, 91, 93, 98, 104, 117, 255, 272, 290. Hard gates only (graduation year, institute tier, marks cutoff, restricted candidate group). Degree level or field (for example Master's in Maths, job 289) goes in the education extraction, not here.
- Not flagged: job 163 (tier I MBA is "preferred"), jobs 29 and 31 (top-tier experience; company mentions IIT alumni), equal-opportunity text in 36, 42, 125, 205, 212, 257, 263.
- is_staffing_or_aggregator: 18 rows at this step: 16, 27, 28, 32, 37, 41, 43, 56, 78, 84, 94, 96, 156, 208, 264, 267, 300, 302. Job 15 added in step 5b (19 rows).
- Not flagged despite name or text hits: 52 (software firm), 71 and 103 (company name differs from URL name; borderline), 273 (training institute, handled under off-target), ordinary "our clients" company text.

## Step 4d: off_target (2026-11-14)

- 31 rows flagged off_target, all from the collection notes. Each title and company was re-checked and a reason code stored (off_target_reason). The rule-based title check found 3 more candidates: 295 (title only, analyst work: kept), 183 (analyst duties, 0-3 years: kept), 276 (IIoT analytics, SQL/Python/Power BI: kept, borderline).
- Reasons: finance_or_accounting 8, ml_or_ai_model_work 5, data_engineering 4, software_dev_or_testing 4, support_or_data_entry_or_placeholder 4, other_job_family 3, teaching_or_training 2, not_an_employer_posting 1.
- Excluded rows stay in the full table; analysis uses off_target == False.
- is_contract corrected: job 12 says "1 year Fixed Term Contract" in the title only, which the description search missed. is_contract is now 4 rows (12, 20, 54, 208).

## Step 4e: borderline (2026-11-14)

- 37 rows flagged borderline, none of them off_target. Kept in the analysis; Phase 4 will show key results with and without them.
- First pass taken from the collection notes, not from a re-read of every description. Reasons: software_requirements_ba 11, mixed_or_low_quality 8, finance_or_regulatory_adjacent 7, sales_or_revenue_ops 5, engineering_or_dev_adjacent 4, data_governance_or_quality 2.
- At this step: 269 of 300 rows on-target (31 off_target), of which 37 borderline. After step 5b the off-target count is 32.

## Step 4 summary: flag counts at the end of step 4 (300 rows)

- is_internship 15, is_remote 19, is_contract 4, has_bond_or_service_agreement 3, eligibility_restricted 11, is_staffing_or_aggregator 18, off_target 31, borderline 37, thin_description 20.
- Later changes: job 15 added to off_target (32) and staffing (19) in step 5b. is_repost_or_dup was set in step 5b.

## Step 5a: duplicate detection (2026-11-14)

- Pandas comparison of all 44,850 row pairs: description overlap (5-word shingles, Jaccard 0.5 or more) or same normalized company and title. 38 candidate pairs; all 15 pairs known from the collection notes were detected.
- New pairs not in the notes: 43/56, 14/49, 150/274, 122/203, 125 (third TriNet copy with 205 and 263), 40/198, 95/242; 15/84 and 24/92 were reviewed in step 5b.
- Not duplicates: MIS Executive template pairs 55/70/101/102 (different employers, same Naukri template); 34/35 (Syntrex) and 134/177 (EXL) have the same company and title but different text (overlap 0.03 and 0.0).
- Job 79 (MitKat) overlaps jobs 30 and 33 at 0.96, although the collection notes called it not a repost; resolved in step 5b.

## Step 5b: duplicates collapsed (2026-11-14)

- Text diffs checked for the unclear pairs. Decisions: 15/84 same Creative Hands HR placeholder (15 flagged off_target and staffing like 84); 30/33/79 (MitKat) same posting in three cities, differing only by an apostrophe encoding, so job 79 IS a repost (the collection note "job 79 not a repost" is corrected); 36/125/205/263 (TriNet) one posting on four portals; 95/242 same posting under two company spellings; 166/291 (Media.net) identical text once spaces and punctuation are ignored; 24/92 not duplicates (shared template line only).
- 20 duplicate groups, 24 rows flagged is_repost_or_dup (LinkedIn 9, Naukri 8, Indeed 5, Foundit 2). 276 unique postings remain.
- Keep rule: the row with the most filled structured fields, lowest job_id on ties. The kept row stores all raw city strings (dup_raw_cities) and the portals it appeared on (dup_sources). Flagged rows are not deleted.
- Confidence: exact for groups with near-identical text (166/291 relabelled exact after the squashed-text comparison); probable for 64/86, 77/141, 82/170/293, 176/303 and 40/198 (overlap 0.5 to 0.8). Phase 4 reports key results with and without probable groups.
- Off-target is now 32 rows (31 from the notes + job 15); staffing 19.
- Analysis set (not off_target and not duplicate): 246 of 300 rows. By source: Naukri 76, LinkedIn 65, Indeed 53, Foundit 52.

## Step 6: off-target exclusion (2026-11-14)

- Done in steps 4d and 5b: off_target is 32 rows (31 from the collection notes + job 15, the same placeholder as job 84). Excluded rows stay in the full table with a reason. The analysis set is not off_target and not is_repost_or_dup: 246 of 300 rows (Naukri 76, LinkedIn 65, Indeed 53, Foundit 52).

## Step 7: city standardization (2026-11-14)

- 83 raw city strings reduced to six metros (Bengaluru, Hyderabad, Pune, Chennai, Mumbai, Delhi/NCR) plus Other and Unknown. Mapping: Pimpri-Chinchwad to Pune; Navi Mumbai and Thane to Mumbai; Gurugram, Noida and Delhi to Delhi/NCR; Serilingampalli to Hyderabad.
- search_city derived from the job_id block each posting was collected under (pilot rows 1-10 have none).
- Primary-city rule, in order (row counts before manual overrides): (1) field names one metro: that metro (272 rows); (2) field names several metros: the search city (19 rows, flag multi_city_posting); (3) field names no metro: the search city (1 row, deduced to be job 189 "Karnataka", flag city_field_no_metro; the id was not printed); (4) field names one metro that differs from the search city: the field wins, flag city_differs_from_search (4 rows: 108, 141, 144, 146); (5) pilot rows decided by hand.
- Manual decisions: jobs 1 and 4 (pilot, "Bengaluru, Hyderabad, Pune") set to Bengaluru, flag city_assumed (the pilot city filter was not recorded); job 8 ("India", no location in the text) Unknown; job 10 (Nagpur, off-target trainer) Other.
- City field contradicts the description: jobs 43 and 56 (title and text say Ahmedabad; portal tags Hyderabad and Pune). Both set to Other, flag city_field_conflicts_description. Without this check they would have counted as a Hyderabad and a Pune opening.
- Job 37 (Pimpri-Chinchwad, Hyderabad, Pune in the field; found in the Hyderabad search; company shown as "MNC") kept as Hyderabad under the multi-city rule.
- Remote postings keep the search city and carry is_remote.
- Final counts, all 300 rows: Bengaluru 64, Delhi/NCR 49, Mumbai 47, Chennai 46, Hyderabad 45, Pune 45, Other 3, Unknown 1.
- Analysis set (246): Bengaluru 55, Delhi/NCR 44, Pune 40, Chennai 36, Hyderabad 35, Mumbai 34, Other 1, Unknown 1. For the six metros, city-by-portal cells run from 7 to 21 rows (Bengaluru-Naukri 21). These follow collection quotas and say nothing about market size.

## Step 8: posting age (2026-11-14)

- Age is measured from date_collected (Naukri 3-6 Nov, LinkedIn 8 Nov, Indeed 9 Nov, Foundit 10-11 Nov; pilot rows 3 Nov).
- posted_ago has 46 distinct values (45 phrasings plus Not mentioned); one parser read all of them (0 unreadable). Months approximated as 30 days ("a month ago" = 30, "2 months ago" = 60).
- Naukri "3+ weeks ago" is open-ended (43 rows): age taken from the Naukri URL date (ddmmyy prefix of the URL ID; parsed 99 of 99, range July 2022 to 6 Nov 2026; checked against posted_ago on a sample).
- Refreshed postings (label specific but URL date more than 30 days older): 2 rows, jobs 94 and 97; the label is used and the conflict flagged (refreshed_label_conflict). Jobs 49 and 58 from the collection notes were not caught by the 30-day test.
- Age known for 238 rows (Naukri 99, LinkedIn 80, Foundit 59). Indeed (62 rows) has no posting date: age unknown, flagged.
- 17 LinkedIn rows say "Reposted"; their age is the repost age, so the original posting is older (is_reposted_label).
- Cutoff decision: is_old = age of 60 days or more (45 days gave 59 rows, 60 gave 58; 30 days would include the coarse "1 month ago" bucket). Old rows are flagged, not removed.
- Results: 58 of 238 known-age rows are old (Naukri 37, LinkedIn 14, Foundit 7). In the analysis set: 193 known age, 50 old (Naukri 31, LinkedIn 12, Foundit 7), 53 unknown (all Indeed), 16 reposted-label rows. Among rows with a known age: median 12 days, max 1,578.
- Any "share of old postings" figure excludes Indeed.

## Step 9a: experience phrases (2026-11-14)

- 184 of 300 rows contain a number-plus-years/months phrase in description_clean; 116 do not (Naukri 61, LinkedIn 23, Indeed 20, Foundit 12). Only 20 of those 116 use fresher or entry-level wording.
- Consequence: description-based exp_min is null for about 40% of rows, most of them Naukri, where the range sits in the header field. Main experience measure stays description-only (as in questions.md); a separate sensitivity column falls back to the portal value and records its source.
- Number-plus-years phrases that are not experience requirements and must be excluded: service bond and agreement terms, company history ("for over N years, we've scaled"), planning horizons, internship duration, and "Fresher (N years)" labels.
- Parser rule: a phrase counts when "experience" or "exp" is within about 40 characters, or it follows an "Experience:" label.

## Step 9: experience from description (2026-11-14)

- Parser reads: ranges with hyphen, en dash or "to"; "N+"; "minimum / at least / over N"; "up to / less than N" (min 0, max N); months divided by 12; "Experience: Fresher" label = 0. A phrase counts only when "experience" or "exp" is within about 40 characters. Units glued to the next word ("2yrsType") are handled.
- Rejected on purpose (17 phrases, checked by eye): service bonds and agreements (61, 91, 93), company history (52, 120, 128, 131, 245), a planning horizon (249), internship durations (39, 142, 184, 215, 255). Job 208 was wrongly rejected and fixed by hand.
- Manual overrides, 15 rows: 169 and 197 ("one year", spelled out), 100 (lost dash, 1-2), 61 (typo "24 years", 2-4), 208 (9-12), 7, 58 (lost dash, 0.5-1), 78, 231 (8-10, the 3-4 is a sub-skill), 245 (4+), 29, 140, 250, 261, 275 (requirements the nearby-word rule missed).
- Rows where phrases disagree: 15 flagged (exp_phrases_disagree). Where unresolved, the phrase with the lowest minimum is used (80, 190, 221, 243, 253, 262, 267, 280); 243 contradicts itself (0-1 in the header table, 1-2 in the body).
- Job 2: text says "Suggested range: 14 years" (lost dash); exp_min set to null (exp_source lost_dash_null), portal value 0-3 kept.
- Jobs 21 (12+) and 153 (10-12) are genuine senior postings; job 21 conflicts with its portal value (0-5).
- Result: exp_min filled for 178 of 300 rows (description 160, manual 15, fresher label 3); 122 null. 20 of the null rows use fresher or entry-level wording only (flag exp_entry_wording).
- Analysis set (246): 149 filled, 97 null. Filled by source: LinkedIn 45 of 65, Foundit 41 of 52, Indeed 38 of 53, Naukri 25 of 76. Naukri is thin because its range sits in the header field and recruiters rarely repeat it.
- Main measure stays description-only (questions.md). A sensitivity column falls back to the portal value and records the source.

## Step 9b: portal experience and sensitivity column (2026-11-14)

- experience_portal parsed for all 26 distinct formats ("0 - 2 years", "3-5 Years", "Fresher", "0 years", ...) into exp_portal_min and exp_portal_max; Not mentioned stays null. Portal values never overwritten.
- exp_min_fallback = description value, else portal minimum; exp_fallback_source records which. Analysis set (246): description 149, portal fallback 66, none 31.
- Caveat: portal ranges starting at 0 count as a minimum of 0, so the fallback inflates the fresher band. It is a sensitivity check only.
- Description vs portal, analysis set: both values present for 69 rows (Foundit 41, Naukri 25, Indeed 3; LinkedIn has no portal experience field). exp_conflict_flag (minimums differ by 1+ year): 13 rows (Naukri 8 of 25, Foundit 5 of 41, Indeed 0 of 3). Description minimum above the portal maximum (desc_min_above_portal_max): 2 rows (jobs 21 and 63).
- Lost-dash rows flagged exp_lost_dash: jobs 2, 100, 58 and 61.

## Step 10: entry-level title flag (2026-11-14)

- Rule from questions.md. entry_title_words: Fresher, Junior or Jr, Trainee, Intern in the title. entry_title_assoc: Associate. entry_title_level: a level marker (I or 1 after Analyst, Executive, Associate or Engineer, or at the end of the title; "II" does not match). Titles matched after replacing underscores with spaces and en dashes with hyphens.
- Bug caught: underscores hid "Fresher" in jobs 38 and 39 (word boundaries treat "_" as a letter). Fixed; the analysis-set count went from 49 to 51.
- Analysis set (246): 51 entry-level by any rule; 33 without Associate; 18 Associate-only. 13 of the 51 are flagged internships; without Associate and without internships: 20 rows.
- Mixed titles that also invite experienced candidates: jobs 32 and 96 (entry_title_mixed).
- Decisions: job 188 "(0 - 1 Year)" is not entry-level by the title rule (no level word); job 210 "Data Analyst-2+year" is not; jobs 38 and 39 are.
- Associate-only rows include roles asking 3 to 5+ years (for example 117, 126, 163, 232), so Q4 is reported with and without Associate.
- Data available for Q4 (description exp known / portal min known / both / neither): any rule 28 / 27 / 13 / 9 of 51; without Associate 15 / 19 / 8 / 7 of 33; without Associate and internships 11 / 15 / 7 / 1 of 20.
- Interns rarely state years, so the internship-free cut is the meaningful base for "still ask for 1+ years". Q4 is reported as counts ("k of N"), not headline percentages.

## Step 11: salary (2026-11-14)

- Portal salary present on 68 of 300 rows (Naukri 36, Indeed 25, LinkedIn 6, Foundit 1). The Foundit row is job 273, an off-target training-institute internship ad. The description added 2 salaries where the portal said Not disclosed (job 67, 1.5-3 LPA; job 149, 12-15 LPA, off-target). Other description hits were false or stipends (284 "5 lakh customers", 184 stipend). No bare-number salary mentions found in the analysis set.
- All values converted to LPA. Rules: Naukri "X-Y Lacs P.A." in lakhs, and a comma-grouped value of 1,000 or more is rupees ("50,000-3 Lacs P.A." = 0.5 to 3.0); Indeed monthly x 12 then / 100,000, Indian digit grouping handled, "From" = minimum only, "Up to" = maximum only; LinkedIn K = 1,000, M = 1,000,000, /month x 12; Foundit "LPA" in lakhs. 0 unparsed.
- Analysis set (246): 56 rows with a salary; 51 after removing 5 internship stipends (119, 143, 215, 216, 224). Usable by source: Naukri 28, Indeed 20, LinkedIn 3, Foundit 0. By city: Bengaluru 13, Hyderabad 8, Pune 8, Delhi/NCR 8, Chennai 7, Mumbai 6, Other 1. 48 have a midpoint (208, 237 and 219 have only one bound).
- Duplicates: no salary lost when collapsing; groups 1/4 and 14/49 carry different values, kept row used.
- Outlier flags (kept in the data; Phase 4 reports medians with and without them): high_pay_10plus_lpa 27, 28, 99, 208, 244 (27 and 28 are staffing postings); high_for_fresher_title 89; minimum_below_1_lpa 48, 57, 58; possible_platform_estimate 202, 237 (identical Indeed minimum); very_wide_range 214. Not checked against the live postings.
- Flags set: salary_outlier, salary_usable (51 rows), salary_usable_clean (39 rows: Naukri 21, Indeed 15, LinkedIn 3; by city Bengaluru 11, Hyderabad 7, Chennai 7, Mumbai 5, Delhi/NCR 5, Pune 3, Other 1). Median midpoint 4.31 LPA with outliers (n=48), 4.06 without (n=38). Descriptive only; no significance claims.
- Descriptive statistics are computed in Phase 4. Salary comparisons by city or skill are shown with counts and no claims of significance.

## Open items

- Glued words (lost line breaks, for example "dataanalysis", "Job DescriptionAs a") are NOT fixed. Skill extraction with word boundaries will miss skills glued to a neighbouring word. Measure how many rows are affected in step 12 before deciding on a fix.
- Boilerplate not stripped yet: equal-opportunity paragraphs (36 rows), fraud warnings (11 rows, mixed with real content), empty template headings (jobs 116, 137), placeholder text (job 154), company website links. To be tested against skill extraction. Appended "Skills:" lines (for example jobs 130, 156, 174, 175) are kept on purpose and marked in step 12.
- Names of individuals in descriptions (collection notes: jobs 245 and 291) must be removed before anything is published. Raw data and full description text stay off GitHub.
- Decisions made without a full read of the data: borderline flags (from the collection notes only), the probable duplicate group 40/198 (not diffed), job 189 as the one "no metro" city row (deduced), salary outliers (not checked against live postings), the pilot city for jobs 1 and 4 (assumed Bengaluru).
- Steps 12 (skills), 13 (education) and 14 (MySQL tables jobs, skills, job_skills) are not done. Step 12 is in progress.
