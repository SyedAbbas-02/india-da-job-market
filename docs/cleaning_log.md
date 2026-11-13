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
