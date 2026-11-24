# Analysis notes (Phase 4)

## Q4 (part 1): the portal "Fresher" label (sql/04_fresher_label.sql, run 2026-11-15)

- The label "Fresher" exists only on Foundit (17 of 59 rows) and Indeed (8 of 62). Naukri shows numeric ranges ("0 - 2 years") and LinkedIn has no experience field, so the label cannot be checked there.
- Verified by reading the descriptions: jobs 251 ("solid experience as a Business Analyst"), 277 ("proven experience in Data Analytics") and 282 ("seeking an experienced professional") ask for experience without a number. So 7 of the 15 usable Foundit postings tagged Fresher ask for experience in the description: 4 with a stated minimum (2, 2, 3 and 8 years) and 3 without a number. The other 8 state no minimum; they were not read individually for implied seniority.
- Indeed, analysis set: 7 rows labelled Fresher; 3 state a minimum, all 0; none asks for 1 or more years.
- All 300 rows: Foundit 17 labelled Fresher (2 outside the analysis set, 1 of them with a stated minimum of 0), Indeed 8 (1 outside).
- Counts are small (15 and 7 rows). These are counts from my sample, not rates for the market.

## Q1: skills in Data Analyst postings (sql/05_q1_skills.sql, run 2026-11-22)

- Base: 102 Data Analyst-titled postings in the analysis set. By description minimum: fresher (0-1 years) 19, experienced (2+) 46, no stated minimum 37 (in the overall column, in neither band).
- A skill counts only when the description states it (desc_level = stated); preferred, keyskills blocks and portal-tag-only mentions are excluded.
- Most common overall: Dashboards/visualization 83 of 102, SQL 78, Power BI 57, Excel 49, Data cleaning/quality 47, Python 44, Tableau 40.
- The fresher band has 19 postings, so one posting moves a percentage by about 5 points. Counts from my sample, not market rates; no significance claims.
- "Dashboards/visualization" is a broad concept bucket, not a tool; read it with that in mind.
- Portal split (sql/06_q1_by_portal.sql): SQL is stated in 82 to 88% of Data Analyst postings on Foundit (21 of 24), Indeed (19 of 23) and LinkedIn (22 of 25) but 53% on Naukri (16 of 30). Counting preferred mentions and portal tags too, Naukri reaches 80% (24 of 30; 4 postings have SQL only as a portal tag). Python on Naukri is 8 of 30 against about 50% elsewhere.
- The bands come from different portals (sql/07_q1_checks.sql). Fresher band (19): Naukri 8, Indeed 6, LinkedIn 5, Foundit 0. Experienced band (46): Foundit 20, LinkedIn 13, Indeed 11, Naukri 2. Naukri has 20 of 30 Data Analyst rows with no stated minimum. The first all-portal comparison (for example Excel 14 of 19 fresher vs 19 of 46 experienced) mixes experience level with portal, so it is not used as a finding.
- Within portal (sql/08_q1_band_within_portal.sql, Indeed and LinkedIn only): SQL fresher vs experienced 5 of 6 vs 8 of 11 (Indeed), 5 of 5 vs 11 of 13 (LinkedIn); Excel 5 of 6 vs 6 of 11 and 2 of 5 vs 5 of 13; Power BI 4 of 6 vs 5 of 11 and 4 of 5 vs 7 of 13; Python 1 of 6 vs 7 of 11 and 3 of 5 vs 6 of 13 (opposite directions). Cell sizes are 5 to 13, so one posting moves a percentage by 17 to 20 points.
- Q1 answer: among the 11 fresher-band Data Analyst postings on Indeed and LinkedIn, 10 state SQL, 8 Power BI, 7 Excel and 4 Python. A skill difference between fresher and experienced postings cannot be separated from portal mix in this sample.
- Limitation for the write-up: Foundit has no fresher-band Data Analyst postings; Naukri bands are mostly unknown.

## Q2: entry-level share and title mix by city (sql/09_q2_entry_by_city.sql, run 2026-11-22)

- Base: analysis set, six main cities (primary_city); 1 "Other" and 1 "Unknown" row left out. City rows: Bengaluru 55, Delhi/NCR 44, Pune 40, Chennai 36, Hyderabad 35, Mumbai 34. Quotas were fixed per city, so this says nothing about city size.
- Entry-level title count by city, any rule / without Associate / strict (no Associate, no internship): Hyderabad 10 / 8 / 5, Mumbai 9 / 4 / 3, Pune 8 / 6 / 2, Bengaluru 10 / 6 / 3, Delhi/NCR 8 / 5 / 4, Chennai 6 / 4 / 3. Totals 51 / 33 / 20 match the cleaning log.
- Hyderabad is highest under all three definitions (10 of 35, 8 of 35, 5 of 35), by 2 to 3 postings. Other cities reorder with the definition: Mumbai drops from 9 to 4 without Associate titles (5 of its 9 are Associate-titled). No reliable difference between cities.
- Title mix by city follows the collection design (fixed title slots per city), not the market. Only Chennai shows a supply signal: 13 of 36 postings are Business Analyst because Data Analyst, MIS and Operations postings were thin there.
- Counts are from my sample; no significance claims.

## Q3 (part 1): salary disclosure by portal (sql/10_q3_salary_disclosure.sql, run 2026-11-22)

- Base: analysis set (246 rows). The portal shows a salary on 55 rows (22.4%); 191 rows say Not disclosed. A parsed salary exists for 56 rows (one extra comes from a description). Usable annual salary: 51 (20.7%). Clean, not outlier: 39 (15.9%).
- By portal, portal shows / usable / clean: Indeed 23 of 53 (43.4%) / 20 / 15; Naukri 27 of 76 (35.5%) / 28 / 21; LinkedIn 5 of 65 (7.7%) / 3 / 3; Foundit 0 of 52 / 0 / 0. (Foundit shows salary on 1 of 59 collected rows; that row is a training-institute ad outside the analysis set.)
- Usable excludes internship stipends (LinkedIn 2, Indeed 3 monthly figures). 12 of 51 usable salaries are flagged as outliers (7 in lakh ranges, 2 annual ranges, 2 from-minimum-only, 1 monthly).
- Counts are small and from my sample, not market rates.

## Q3 (part 2): salary by city (sql/11_q3_salary_outliers.sql, sql/12_q3_salary_by_city.sql, run 2026-11-22)

- Outlier review (all 51 usable salaries read by hand): the 12 flags were kept. Reasons: high pay (jobs 99, 244, 28, 27, 208), high for a fresher title (89), probable platform estimate (202, 237), very wide range (214), minimum below 1 LPA (48, 57, 58). Job 147 (LinkedIn Chennai, 5 to 17 LPA) was not flagged but has the same kind of range as job 214, so it is excluded from the city medians.
- Salary measure: midpoint of the posted range. Rows with a minimum only (237, 208) or a maximum only (219) have no midpoint and are left out. Pool: 37 clean rows with a midpoint (39 clean, minus job 147, minus job 219).
- Median midpoint (LPA) with n: Bengaluru 4.50 (11), Hyderabad 4.13 (7), Mumbai 6.00 (5), Delhi/NCR 3.90 (5), Chennai 2.58 (5). Pune (3) and Other (1) are too few to report.
- Jobs 27 and 28 (10 to 16 LPA, Bengaluru) do not change the Bengaluru median (4.50 with and without them). Including all outliers moves Delhi/NCR to 4.50, Chennai to 2.82 and Pune to 2.58.
- Cities cannot be ranked by salary: each city has 5 to 11 postings, ranges mix fresher and 2 to 8 year roles (Mumbai's three highest rows ask 1, 3 and 8 years), and portals differ (Naukri ranges vs Indeed monthly figures converted to annual). Posted ranges are not pay.
- Counts from my sample; no significance claims.

## Q3 (part 3): salary by skill (sql/13_q3_salary_by_skill.sql, run 2026-11-22)

- Pool: the same 37 clean salaries with a midpoint. A skill counts only when the description states it; "not stated" mixes jobs that do not need the skill with thin descriptions.
- Median midpoint (LPA), stated vs not stated, n in brackets: SQL 4.50 (21) vs 3.53 (16); Python 4.75 (8) vs 3.90 (29); Tableau 4.25 (14) vs 4.00 (23); Power BI 4.06 (18) vs 4.00 (19); Excel 4.00 (33) vs 3.41 (4).
- Excel is stated in 33 of 37 salary rows, so there is no usable comparison group. Power BI and Tableau show no difference. SQL and Python lean higher but the groups mix fresher and 2 to 8 year roles and different portals, and all ranges overlap (about 1.5 to 6.6 LPA).
- Q3 answer: most postings hide salary (191 of 246 in the analysis set; 39 clean salaries), and the few that show it are too few and too mixed to link salary to city or skill. No salary premium for any skill is claimed.

## Q4: the experience gap for entry-level titles (sql/14_q4_experience_gap.sql, run 2026-11-22)

- Base: analysis set, three versions of the entry-level title rule: any (with Associate) 51 rows, without Associate 33, strict (no Associate, no internship) 20. Experience from the description (exp_min); a posting with no number is counted separately, never as 0.
- Any rule: 28 of 51 state a minimum; 14 of those ask 1+ years and 11 ask 2+; 23 state no number. Without Associate: 15 state a minimum, 6 ask 1+, 4 ask 2+, 18 state no number. Strict: 11 state a minimum, 6 ask 1+, 4 ask 2+, 9 state no number.
- This is a floor, not a rate for all entry-level postings: the postings with no stated number may or may not ask for experience. Naukri has 11 of 15 entry-level rows with no number in the description.
- By portal (any rule), rows / state a minimum / ask 1+: Foundit 10 / 7 / 6; LinkedIn 18 / 10 / 6; Indeed 8 / 7 / 1; Naukri 15 / 4 / 1. Cells are 4 to 10 rows, so direction only.
- Junior and level-I titles also ask for experience: job 270 (2 to 5 years), 151 (2 to 4), 174 (1 to 2), 286 (3 to 5), 261 (2 to 3), 250 (1 to 3). All 14 rows asking 1+ years were read in the Part C list.
- Description vs portal: 13 any-rule rows have both values; 3 differ by 1+ year (jobs 261, 303, 52), always with the portal lower (portal 0, description 2). Strict rule: 1 of 7 (job 261). The portal Fresher label is the unreliable part; portal ranges usually match the description.
- Counts from my sample; no significance claims.

## Q5: Title vs Data Analyst skills (sql/15_q5_title_skill_overlap.sql)

- Reference: 102 q1_base Data Analyst rows; top 10 skills = Dashboards/visualization, SQL, Power BI, Excel, Data cleaning/quality, Python, Tableau, Statistics, Pivot tables, Machine learning (no tie at rank 10). Skills counted where desc_level = 'stated'. "Other" titles (18 rows) excluded.
- Average share of the top 10 stated per posting: Data Analyst 45.9% (n 102), MIS 31.8% (n 34; 37.6% without 9 thin rows), Business Analyst 27.2% (n 60; unchanged without thin or borderline rows), Operations 32.0% (n 15; 21.7% on the 6 clean rows, not reportable).
- Ranking: MIS closest, BA furthest. Percentages are not precise: the top 10 comes from the Data Analyst rows, which biases the baseline upward. Counts are small and no significance is claimed.
- Operations: 15 rows (Naukri 2, Indeed 3), mostly sales or revenue operations; shown with counts only.
