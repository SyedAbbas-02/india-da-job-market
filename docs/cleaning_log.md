# Cleaning log

## Step 1: Load and inspect (2026-11-13)

- Raw file: 300 rows x 17 columns, 300 unique job_ids, 300 unique URLs. Naukri 99, LinkedIn 80, Indeed 62, Foundit 59.
- 0 empty cells. Placeholders: salary Not disclosed 232 (77%), skills No tags 142, experience_portal Not mentioned 134, posted_ago Not mentioned 62 (all Indeed).
- 294 unique descriptions of 300: 6 exact repeats, matching the 6 known repost pairs.
- 83 distinct city spellings; to standardize.
- work_mode_portal has "Hybrid work" (1) and "Hybrid" (22); to merge.
- industry_type: 143 Not mentioned, 50 "Other", labels differ by portal; not merged.

## Step 2a: Short text columns (2026-11-13)

- Trimmed/collapsed whitespace, non-breaking spaces and zero-width characters: job_title 9 values changed, education 63 (line breaks between UG and PG), all other short text columns 0.
- Placeholder casing variants: 0 found.
- work_mode_clean created: "Hybrid work" (1) merged into "Hybrid"; Hybrid 23, On-site 56, Remote 13, Not mentioned 208. Original work_mode_portal kept.

## Step 2b: description_clean (2026-11-13)

- description_text kept unchanged; cleaned copy in description_clean.
- Mojibake fixed in 2 rows (job 200: curly apostrophes; job 292: broken dash). 0 left.
- Non-breaking hyphens replaced: 5 rows. Zero-width characters removed: 1 row. Citation markers like [1] removed: 1 row (job 214). Repeated spaces collapsed: 8 rows.
- Leading/trailing whitespace stripped (blank lines at the end of some descriptions).
- Total rows where description_clean differs from description_text: 28 of 300.
- Not done yet: glued words (lost line breaks), boilerplate stripping. Both come next, in that order of risk.

- Naukri/Foundit disclaimer plus the field block after it: 26 rows cut (Naukri 25, Foundit 1), 12,692 chars removed. No skill or experience text found after the disclaimer in any row.
- Same Naukri field block (Role, Industry Type, Department, Employment Type, Role Category, Education, UG/PG) in rows without a disclaimer: 73 rows cut (all Naukri), 18,426 chars removed. All 99 Naukri rows had one of the two kinds of boilerplate.
- Job 67: its "Role Category" block is the employer's own text (age, office timing, working days, education); left in place, to be read during extraction.
- Job 3: description is almost only the field block; see next entry.

- Job 3: real text is one sentence ("freshers... data analyst... contact"), field block on the same line with no line break; block cut with an inline rule. Description now about 130 chars, no skills; kept, flagged thin.

## Step 3 (continued): description length (2026-11-13)

- Final description_clean length: min 125, median 2,428, max 16,635 chars.
- thin_description flag (under 500 chars): 20 rows (Naukri 16, Indeed 3, Foundit 1), 3 of them under 300 (jobs 3, 27, 102). Kept and flagged; skill results to be checked with and without them.

## Step 4a: is_internship (2026-11-13)

- Rule: title contains intern/internship, plus one description-based case. 15 rows flagged (LinkedIn 8, Indeed 3, Foundit 3, Naukri 1): jobs 118, 119, 130, 142, 143, 144, 159, 184, 215, 216, 224, 255, 264, 273, 39.
- Job 39 flagged by description ("Position: Business Analyst (Intern)", 3 months, then permanent); its title does not say intern.
- Job 97 ("Business Analyst- Intern/Freshers") NOT flagged: portal says Full Time, Permanent and the description never mentions an internship. Judgment call.
- Jobs 22, 38, 93, 227 mention "internship experience" as a requirement only; not flagged.
- Naukri Employment Type has no Internship value (92 Full Time Permanent, 4 Full-Time, 1 Full-Time., 1 Full Time Temporary/Contractual, 1 Part Time Temporary/Contractual).
- Flagged rows are excluded from the salary analysis (stipends).

## Step 4b: is_remote and is_contract (2026-11-13)

- is_remote: 19 rows = 13 where the portal says Remote (jobs 8, 27, 28, 32, 54, 94, 99, 118, 122, 141, 159, 169, 203) + 6 where the description says remote but the portal does not (77, 184, 255, 264, 277, 296).
- Portal and description disagree on work mode: 77 (portal Hybrid, description Remote), 184 (portal On-site, description Remote), 123 and 259 (portal Not mentioned, description hybrid). Portal value kept in work_mode_portal.
- Not flagged remote: 123, 259, 163, 213, 301 (hybrid or one WFH day); 216 and 224 ("Hybrid remote" is Indeed's wording for hybrid). Judgment call.
- Remote postings keep the search city; the city is not meaningful for them (203, 277, 296 and others).
- is_contract: 3 rows: 20 and 54 (Naukri Employment Type Temporary/Contractual), 208 (contract basis, third-party payroll).
- Job 233 lists "Contract / Freelance" among options only; not flagged (it is an excluded trainer role anyway).
- "Contract Type : Permanent" (82, 170, 293) and benefits or legal text using the word "contract" are not contract roles.

## Step 4c: bond, eligibility, staffing flags (2026-11-13)

- Keyword searches produce many false hits (equal-opportunity paragraphs mentioning persons with disabilities, "we bond beyond work", "our clients"), so every flagged row was read in context and the reason is stored (eligibility_reason, staffing_reason).
- has_bond_or_service_agreement: 3 rows: 61 (1-year commitment), 91 (2-year agreement), 93 (2.5-year agreement). Jobs 91 and 61 were not found by the first keyword pass (spacing, and job 61 was only logged as "bond" in non-job text).
- eligibility_restricted: 11 rows: 38, 74, 88, 91, 93, 98, 104, 117, 255, 272, 290. Hard gates only (graduation year, institute tier, marks cutoff, restricted candidate group). Degree level or field (for example Master's in Maths, job 289) goes in the education extraction, not here.
- Not flagged: job 163 (tier I MBA is "preferred"), jobs 29 and 31 (top-tier experience; company mentions IIT alumni), equal-opportunity text in 36, 42, 125, 205, 212, 257, 263.
- is_staffing_or_aggregator: 18 rows: 16, 27, 28, 32, 37, 41, 43, 56, 78, 84, 94, 96, 156, 208, 264, 267, 300, 302.
- Not flagged despite name or text hits: 52 (software firm), 71 and 103 (company name differs from URL name; borderline), 273 (training institute, handled under off-target), ordinary "our clients" company text.

## Step 4d: off_target (2026-11-13)

- 31 rows flagged off_target, all from the collection notes. Each title and company was re-checked and a reason code stored (off_target_reason). The rule-based title check found 3 more candidates: 295 (title only, analyst work: kept), 183 (analyst duties, 0-3 years: kept), 276 (IIoT analytics, SQL/Python/Power BI: kept, borderline).
- Reasons: finance_or_accounting 8, ml_or_ai_model_work 5, data_engineering 4, software_dev_or_testing 4, support_or_data_entry_or_placeholder 4, other_job_family 3, teaching_or_training 2, not_an_employer_posting 1.
- Excluded rows stay in the full table; analysis uses off_target == False.
- is_contract corrected: job 12 says "1 year Fixed Term Contract" in the title only, which the description search missed. is_contract is now 4 rows (12, 20, 54, 208).

## Step 4e: borderline (2026-11-13)

- 37 rows flagged borderline, none of them off_target. Kept in the analysis; Phase 4 will show key results with and without them.
- First pass taken from the collection notes, not from a re-read of every description. Reasons: software_requirements_ba 11, mixed_or_low_quality 8, finance_or_regulatory_adjacent 7, sales_or_revenue_ops 5, engineering_or_dev_adjacent 4, data_governance_or_quality 2.
- On-target rows after step 4: 269 of 300 (31 off_target), of which 37 borderline.

## Step 4 summary: flag counts (300 rows)

- is_internship 15, is_remote 19, is_contract 4, has_bond_or_service_agreement 3, eligibility_restricted 11, is_staffing_or_aggregator 18, off_target 31, borderline 37, thin_description 20.
- is_repost_or_dup: not set yet; next step.
