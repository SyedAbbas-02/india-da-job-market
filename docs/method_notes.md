# Method notes

## Collection rules

- Portal fields fill the structured columns exactly as shown
- Experience, skills and education are extracted from description text in Phase 3, same rules for all sources
- Missing values use: Not mentioned / Not disclosed / No tags / Confidential
- Phone numbers and emails in descriptions are replaced with [removed]
- For the Data Analyst search, include a posting if its main work is analyzing or reporting on data (SQL, Excel, Power BI, Tableau, Python, dashboards, reporting). For Business Analyst, MIS, Operations and other title searches, skip only a different job family (accounting or bookkeeping, teaching or training, sales or support, pure compliance or audit, ML/AI model building); do not skip for lacking data tools, so Question 5 is not biased.
- Check the Role field and the main work before collecting; a generic title such as "Analyst" can hide a non-analysis role.
- Collection plan: one portal per block with targets (Naukri 100, LinkedIn 80, Indeed 60, Foundit 60), instead of a daily mix. Exact duplicates (same URL job ID) are skipped and counted; reposts (same company and title, different URL job ID) are collected.
- Naukri plan (jobs 31 to 106): 14 postings each in Hyderabad, Pune, Chennai, Mumbai and Delhi/NCR, plus 6 in Bangalore, with a fixed title mix per city (Data Analyst, Junior/Fresher Data Analyst, Business Analyst, MIS Executive, Operations Analyst). Shortfalls added to Data Analyst in the same city.

## Things noticed (add one line each time)

### Pilot and setup

- Jobs 1 and 4 look like reposts of the same posting (same company, cities, description opening; salary and tags differ). Descriptions are word-for-word identical.
- Job 2: description text lost a dash in the experience line, so portal header value was used
- Job 3: description contained an email and a phone number; replaced with [removed]. Rule for all rows: contact details replaced with [removed], rest of the text unchanged.
- LinkedIn has no skill tags or experience field; Naukri does
- Pilot (n=10: 4 Naukri, 4 LinkedIn, 2 Indeed) took about 1.5 hours; later postings take less
- Portal header fields differ: Naukri shows salary, experience and skill tags; LinkedIn and Indeed mostly do not (salary shown for 5 of 10 pilot postings, all Naukri except one Indeed)
- Target revised from 400 to 300 postings (stretch 400) because of collection time
- Job 10 (Indeed): "Data Analyst Trainer" is a teaching role that matches the search term but not the job type; decide in Phase 3 whether to exclude
- Portal columns renamed with a _portal suffix (experience_portal, skills_portal, salary_portal, work_mode_portal) because extracted values from description text become separate columns in Phase 3

### Day 1, Naukri, Bangalore block (jobs 11 to 30)

- Day 1 search: "data analyst", Bangalore filter, sorted by Date. Quoted and unquoted searches gave the same results (1 off-target in the first 20, a risk analyst), so quotes are not used.
- Day 1: all 20 Naukri postings came from the Bangalore filter, but many list several cities in the city field. Multi-city postings need a rule in Phase 3 (count once per city or use a primary city).
- Day 1: reviewed about 80 to 100 Naukri postings (4 to 5 pages) and collected 20; about 60 to 80 skipped as off-target or already seen.
- Naukri skill tags copied with a browser console command that joins the tag text with commas; wording unchanged, checked against the page on the first postings.
- Job 12 (ABB): "Financial Analyst", accounts payable/SAP work, not data analysis; decide in Phase 3 whether to exclude. Description also mixes "receivables" and "payable" and says "Freshers with 1-2 years of experience" (cleaning log example).
- Job 12 (ABB): portal education says "Any Graduate / Any Postgraduate" but description asks for a Commerce, Accounting or Finance degree. Portal and description disagree; extract both in Phase 3.
- Jobs 13, 14, 15, 16: portal education says "Any Graduate / Any Postgraduate".
- Job 17: portal education lists only BBA/BMS/B.Com, so engineering degrees are not listed. Finance role, not data analysis; decide in Phase 3 whether to exclude.
- Job 17: headline title is "Data Research Analyst" but the Role field says "Private Equity Analyst". Job 12: headline "Accounting & Reporting Analyst", Role field "Financial Analyst". job_title holds the headline.
- Jobs 19, 20: ML/AI roles (AI Analyst, Data Science Engineer), not data analysis; decide in Phase 3 whether to exclude. Job 22 (Business Analyst) looks like software support (B.Tech CSE, support skill tags); borderline.
- Date sort on Naukri does not give strict order; older postings (1 to 3+ weeks) appear after newer ones. Filter on posted_ago in Phase 3.
- Skills in skill tags often differ from skills in the description (tags are recruiter-chosen); both are kept, description extraction happens in Phase 3.

### Day 1, Naukri, Hyderabad block (jobs 31 to 44)

- Hyderabad block done. Title mix: Data Analyst 5, Business Analyst 5, MIS 2, "Analyst" 2, Reporting Analyst 0.
- Reporting Analyst: all-India Naukri search (about 5 pages, 100 results) gave only 2 to 3 Reporting Analyst titles. Rare on Naukri, so Operations Analyst replaces it as a comparison title from Pune onward. Titles for Question 5 are sampled by searching the title, not from the Data Analyst search.
- Jobs 30 and 33 (MitKat, Data Analyst, 0 to 1 years): identical descriptions, different URL IDs and city tags (Bengaluru, Hyderabad). Reposts differing only by city; collapse in Phase 3.
- Job 37: city field starts with "Pimpri-Chinchwad" although found in the Hyderabad search; company shown as "MNC". Primary city cannot be the first listed city; company name cannot be used alone for deduplication.
- Job 41: titled "Analyst" but Role is Customer Success Associate (BPO, data entry); requirements marked "not yet active from Client's side". Off-target; decide in Phase 3 whether to exclude.
- Job 43: title and description say Ahmedabad, but the city field says Hyderabad (portal tag). Company name is truncated with "…". City needs checking against the description in Phase 3.
- Naukri applicants column mostly shows "100+" (portal cap); not usable for analysis.

### Formats to clean in Phase 3

- Education pasted with a line break between UG and PG on some rows (cell paste with wrap on); casing also varies ("Any graduate" vs "Any Graduate"). Normalize in Phase 3.
- City field: "Bengaluru( Bannerghatta Road )", "Hiring office located in Bengaluru", "Mumbai (All Areas)", repeated cities within one cell.
- Boilerplate such as company URLs and fraud warnings appears in some descriptions (ABB, Log9); strip in Phase 3 before skill extraction.
