# Analysis notes (Phase 4)

## Q4 (part 1): the portal "Fresher" label (sql/04_fresher_label.sql, run 2026-11-15)

- The label "Fresher" exists only on Foundit (17 of 59 rows) and Indeed (8 of 62). Naukri shows numeric ranges ("0 - 2 years") and LinkedIn has no experience field, so the label cannot be checked there.
- Verified by reading the descriptions: jobs 251 ("solid experience as a Business Analyst"), 277 ("proven experience in Data Analytics") and 282 ("seeking an experienced professional") ask for experience without a number. So 7 of the 15 usable Foundit postings tagged Fresher ask for experience in the description: 4 with a stated minimum (2, 2, 3 and 8 years) and 3 without a number. The other 8 state no minimum; they were not read individually for implied seniority.
- Indeed, analysis set: 7 rows labelled Fresher; 3 state a minimum, all 0; none asks for 1 or more years.
- All 300 rows: Foundit 17 labelled Fresher (2 outside the analysis set, 1 of them with a stated minimum of 0), Indeed 8 (1 outside).
- Counts are small (15 and 7 rows). These are counts from my sample, not rates for the market.
