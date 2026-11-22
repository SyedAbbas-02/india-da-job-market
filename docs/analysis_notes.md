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
