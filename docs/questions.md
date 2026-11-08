# Questions for this project

## Scope rules (apply to all five questions)

- Every answer uses the cleaned dataset: exact duplicates removed, reposts and cross-portal duplicates collapsed, off-target rows excluded. The number of rows removed at each step goes into the cleaning log.
- Experience comes from the description text (exp_min), not the portal field, because the two often disagree. The portal value is kept for comparison.
- Entry-level title means the title contains Fresher, Junior or Jr, Trainee, Intern, Associate, or a level marker such as "I". Q4 reports results with and without Associate titles.
- Samples are small (a few dozen rows per city). Report counts next to percentages and make no claims of statistical significance.
- Naukri and LinkedIn differ (Naukri has salary, experience and skill tags; LinkedIn skews toward large multinationals). Show the portal split where it changes the answer.

## Questions

1. Skills: Which skills appear most in Data Analyst postings (Data Analyst, Junior or Fresher Data Analyst titles), and how does that differ between the fresher band (minimum 0 to 1 year required) and the experienced band (minimum 2+ years)?
2. Cities: Which cities have the highest share of entry-level roles, and how does the title mix differ by city? (Collection used a fixed quota per city, so city size is not estimated. Multi-city postings are assigned one primary city by a rule set in Phase 3.)
3. Salary: What share of postings disclose salary, by portal? Where annual salary is disclosed, how does it vary by city and by skill? (Expect most postings to hide salary. That's a finding too. Internship stipends are excluded and outliers are checked before use.)
4. Experience gap: What share of entry-level titled postings still ask for 1+ years of experience in the description, and how often does that differ from the portal's experience field?
5. Titles: Which titles (Business Analyst, MIS Executive, Operations Analyst and so on) ask for the same skills as Data Analyst roles, measured as the share of the top 10 Data Analyst skills each title asks for? (Reporting Analyst postings were too rare on Naukri to compare, and Operations Analyst postings are thin on both Naukri and LinkedIn, which is itself a finding. Titles were sampled by searching each title, so this compares skills, not market share.)
