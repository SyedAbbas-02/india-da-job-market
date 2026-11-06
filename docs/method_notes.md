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

### Day 2, Naukri, Pune block (jobs 45 to 61)

- Sort method: Pune onward uses Relevance sort, because Date sort returned many off-target postings (60 to 80 skipped per block). No Freshness filter available. Bangalore and Hyderabad blocks (jobs 11 to 44) were a mix of Date and Relevance sort, not recorded per posting.
- Pune block done, 15 rows after duplicate removal (jobs 45 to 61, minus 47 and 50). Title mix: Data Analyst-titled 6, Fresher DA 2, Business Analyst 3 (jobs 59 to 61), MIS 3, Operations 1. Pune is 1 row over the 14-per-city design.
- Job 54 (Peroptyx): Maps Evaluator, part-time contract, Marathi language requirement, not data analysis; exclude candidate for Phase 3.
- Job 59 (LeadWinner): headline "Business Analyst", Role "Full Stack Developer", description is AngularJS and Java development; off-target, exclude candidate for Phase 3.
- Jobs 48, 49, 51: multi-city fields that include Pune plus Nagpur, Mumbai, Kolkata, Chennai, Noida or Delhi/NCR. Expect the same postings in other city blocks; skip exact URL ID duplicates and count them.
- Job 56: title and description say Ahmedabad, city field says Pune; company shown as "Leading and Reputed Fastest growing comp…" (URL says precise-talent-hunt). Role is Back Office Executive. Same pattern as job 43.
- Job 52: portal experience 0 - 3 years, but description says "over 2 years" and "2+ years". Description also has line breaks inside "e.g." and company boilerplate (About Aumni).
- Job 61: portal experience 0 - 5 years, description says 2 to 4 years and "24 years" (typo); includes non-job text (gender, bond, QR scan); Industry Type "Management Consulting" for a banking-software role.
- Job 60 (Barclays): portal experience 0 - 13 years (AVP-level posting); long boilerplate (values, AVP expectations) to strip in Phase 3.
- Job 51: portal salary 2.5-4 Lacs P.A., description says 20k to 40k per month. Salary conflict.
- Salary format: jobs 48, 57, 58 start with "50,000-" (rupees) and end in "Lacs P.A." (lakhs). Parsing rule needed in Phase 3 (50,000 = 0.5 LPA).
- Job 49: description has a stuffed "Key Skills" block (Data Entry, Back Office, SQL, Python, Tableau) that conflicts with the requirements section ("Basic knowledge of SQL is an added advantage"). Skill extraction from the full text will overcount; decide a rule in Phase 3.
- Job 48: title "Data Analytics Analyst", Role "Data Engineer", Role Category Data Science & Machine Learning; description is analyst work. URL source is "similar jobs", not the search list.
- Disclaimer boilerplate appears in jobs 45, 53, 55, 59 and 61; strip in Phase 3.
- posted_ago "3+ weeks ago" is an open-ended bucket (job 60 URL ID points to 30 Mar 2026). Jobs 49 and 58 show newer labels than their URL ID dates (likely refreshed postings). Derive posting date from the URL ID in Phase 3.

### Day 2, Naukri, Chennai block (jobs 62 to 76)

- Chennai block done, 14 rows (jobs 62 to 76; job 65 removed as a duplicate and left unused). Title mix: Data Analyst 2, Fresher/Trainee DA 1, Business Analyst 7, MIS 3, Operations 1. Searches for Data Analyst, Fresher, MIS and Operations returned very few postings in Chennai, so Business Analyst postings were added to fill the block. Thin supply outside BA is itself a finding.
- Duplicate check run on jobs 1 to 76 by formula (Naukri URL text before the "?"): 3 exact duplicate pairs found (URL IDs 021126000295, 311026015204, 191026019525). Rows 47, 50 and 65 deleted; kept rows are job 16 (Jobaaj), job 35 (Syntrex) and job 49 (Nova Technologies). Job_ids left as gaps. The earlier Ctrl+F check on the full URL missed these because the part after "?" differs between visits. For LinkedIn and Indeed the job ID is after the "?", so this formula does not apply to them.
- Job 69 was typed as 77 by mistake; corrected. Education for jobs 72 to 75 was pasted from job 71; corrected to match each description.
- Job 72 (LeadWinner): repost of job 59 with a different URL ID; Role Full Stack Developer; off-target, exclude candidate; collapse with job 59 in Phase 3.
- Job 76 (Marlensoft): headline "Business Analyst", Role "Test Analyst", software testing work; off-target, exclude candidate.
- Job 71 (nStore Technologies): titled "Operations Analyst" but the work is customer support (Hindi, BPO, rotational shifts); URL says xmile-associates; off-target, exclude candidate. First posting with applicants "50+".
- Job 68 (Qube Cinema): description says "Status: Closed" and "Experience: 3 - 6 years"; portal says 0 - 3 years. Closed posting still live.
- Job 63: portal 0 - 2 years, description says "3+ Years Experience". Job 66: portal 0 - 1 years, description asks for "proven knowledge as a Data Analyst" and a course certificate "is a must".
- Job 67: portal salary Not disclosed, description says 1.5LPA - 3LPA; portal 0 - 2 years, description says 0-3; description also lists an age range.
- Job 69: skills_portal (legal documentation, litigation matters, training) does not match the description.
- Template descriptions with almost no skill content (jobs 62, 69, 70, 75, and job 55 in Pune): skill extraction will be sparse for these.
- Jobs 74 and 75 list 7 cities each (Bengaluru, Kolkata, Mumbai, New Delhi, Hyderabad, Pune, Chennai); expect them again in other blocks and skip exact URL ID duplicates. Job 74 description is a pasted JSON-like block with duplicated items.
- Relevance sort surfaces old postings: by URL ID date, only 3 of 14 postings in this block are from the last two months; jobs 76, 74, 75 and 70 look like 2023 to 2025.

### Limitations (for the Phase 6 write-up)

- Naukri sort order varied across blocks (Date or a mix in Bangalore and Hyderabad, Relevance from Pune onward), so sampling is not strictly uniform.
- Pune has 15 rows against 14 for other Naukri cities.
- Relevance sort returns many old postings (some from 2023 to 2025 by URL ID date), so "current openings" may be overstated; filter on URL date in Phase 3.
- Chennai has few Data Analyst, MIS and Operations postings on Naukri, so its block is mostly Business Analyst.
