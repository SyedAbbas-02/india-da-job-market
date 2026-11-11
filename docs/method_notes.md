# Method notes

## Status

- Naukri closed at 99 rows (including 4 pilot rows), target 100.
- LinkedIn closed at 80 rows (including 4 pilot rows), target 80.
- Indeed closed at 62 rows (including 2 pilot rows), target 60: Bengaluru 12 (jobs 185 to 196), Hyderabad 10 (197 to 206), Pune 10 (207 to 216), Chennai 9 (217 to 225), Mumbai 8 (226 to 233), Delhi/NCR 11 (234 to 244). Sheet total after Indeed: 241 rows (Naukri 99, LinkedIn 80, Indeed 62).
- Foundit closed at 59 rows (target 60): Bengaluru 11, Hyderabad 9, Pune 9, Chennai 10, Mumbai 10, Delhi/NCR 10. Sheet total 300 (Naukri 99, LinkedIn 80, Indeed 62, Foundit 59). Phase 2 collection closed.
- Job_id gaps: 47, 50, 65 (exact duplicates deleted). Job_ids 1 to 303 minus these 3 gaps = 300 rows.

## Collection rules

- Portal fields fill the structured columns exactly as shown; copy portal wording exactly
- Experience, skills and education are extracted from description text in Phase 3, same rules for all sources
- Missing values use: Not mentioned / Not disclosed / No tags / Confidential. Never blank, never NA or 0
- Phone numbers and emails in descriptions are replaced with [removed]; the rest of the text is unchanged
- Foundit masks contact details itself as "[Confidential Information]" (jobs 255, 263, 267, 301). Kept as shown; treated the same as [removed] in Phase 3.
- No scraping. All postings are collected by hand
- No date, salary or experience filters. A city filter is allowed (deviations are listed under Limitations)
- Log titles as the posting shows them; job_title holds the headline
- For the Data Analyst search, include a posting if its main work is analyzing or reporting on data (SQL, Excel, Power BI, Tableau, Python, dashboards, reporting). For Business Analyst, MIS, Operations and other title searches, skip only a different job family (accounting or bookkeeping, teaching or training, sales or support, pure compliance or audit, ML/AI model building); do not skip for lacking data tools, so Question 5 is not biased.
- Check the Role field and the main work before collecting; a generic title such as "Analyst" can hide a non-analysis role.
- Off-target rows that get collected are kept and logged as exclude candidates, not deleted. The exclude decision is made in Phase 3.
- Reposts (same posting, different URL job ID) and cross-portal duplicates are kept and collapsed in Phase 3.
- Internship stipends stay out of the salary analysis.
- Collection plan: one portal per block with targets (Naukri 100, LinkedIn 80, Indeed 60, Foundit 60), instead of a daily mix. Exact duplicates (same URL job ID within one portal) are removed at the end-of-block check and counted. Shortfalls are accepted; never pad with off-target postings.
- Naukri plan: 14 postings each in Hyderabad, Pune, Chennai, Mumbai and Delhi/NCR, plus 6 in Bangalore (second pass; 4 collected), with a fixed title mix per city (Data Analyst, Junior/Fresher Data Analyst, Business Analyst, MIS Executive, Operations Analyst). Job_id ranges shifted after Pune: Mumbai 77 to 90, Delhi/NCR 91 to 104, Bangalore second pass 105 to 108. Shortfalls are filled only with on-target postings; a smaller block is accepted rather than padding with off-target ones.
- Duplicate check before each block's rows are final: copy the sheet, compare the URL job ID, delete the later row of any pair and leave the gap. Naukri: URL text before the "?". LinkedIn: currentJobId value. Indeed: jk value.

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
- Job 35 (Syntrex): one posting describes two roles (Business Analyst and Data Analyst), experience "0 years".
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
- Jobs 48, 49, 51: multi-city fields that include Pune plus Nagpur, Mumbai, Kolkata, Chennai, Noida or Delhi/NCR. Expect the same postings in other city blocks; exact URL ID duplicates are removed at the end-of-block check and counted.
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
- Jobs 74 and 75 list 7 cities each (Bengaluru, Kolkata, Mumbai, New Delhi, Hyderabad, Pune, Chennai); expect them again in other blocks; exact URL ID duplicates are removed at the end-of-block check. Job 74 description is a pasted JSON-like block with duplicated items.
- Relevance sort surfaces old postings: by URL ID date, only 3 of 14 postings in this block are from the last two months; jobs 76, 74, 75 and 70 look like 2023 to 2025.

### Day 3, Naukri, Mumbai block (jobs 77 to 90)

- Duplicate check on jobs 1 to 90: 0 pairs found.
- Job 77 (Zema Global): portal work mode Hybrid, description says "Work Mode: Remote"; description says up to 1 year of experience, portal 0 - 2 years. Rotational shifts (AU, UK, US).
- Job 78 (Happy Square): headline "Data Analyst", description title "Executive - QA - Data" at a food company; data entry into QA trackers and basic Excel; portal industry Financial Services; URL says white-force-outsourcing-services. Off-target, exclude candidate.
- Job 79 (MitKat): description lists Mumbai, Gurgaon, Hyderabad and Bangalore; compared with jobs 30 and 33 and it is not a repost (location and description differ). Description says "experienced" against portal 0 - 1 years.
- Job 80 (Incanus): very long description with many "preferred" skills (Macros, VBA, Power BI, SQL as an added advantage); skill extraction will overcount; multi-city field (Bengaluru, Gurugram, Mumbai).
- Job 84 (Creative Hands HR): placeholder posting, "requirements are not yet active from Client's side", no real duties. Same pattern as job 41; exclude candidate for Phase 3.
- Job 90 (Neoteric): market research role; Role field "Research Associate / Engineer", category Pharma & Biotech; off-target and off-plan title, exclude candidate. Description repeats a sentence.
- Job 87 (Navadhan): generalist role across product, strategy and HR coordination, Role field "Strategic & Top Management - Other"; borderline. Company shown as "Navadhan Capitali" (URL says navadhan-capital).
- Job 89 (Muthoot): Role field Finance & Accounting; portal salary 7.5-9.5 Lacs P.A. for a 0-year role (check as outlier in Phase 3); portal education "Graduation Not Required" but description asks for a Finance or Economics degree.
- Job 86 (Securens Systems): repost of job 64 (Chennai) with a different URL ID; description differs slightly.
- Job 83: company shown as "AM NS India" but the URL says essar-minmet. Salary cell had "Not Disclosed" and was corrected to "Not disclosed".
- Job 85: title MIS Executive but Role field is Business Analyst; URL ID date points to Dec 2024.
- Job 88: portal experience 0 - 1 years, description says "2 to 6month" and asks for a B-Tech from a premier institute.
- Job 82: description repeats the equal-opportunity paragraph twice; says "0-2 years... experienced candidates preferred".
- Job 81: posted_ago "Just Now" (new bucket), applicants "10" (a real number, not the 100+ cap). Description mixes data analytics with operations research and budget management.
- Mumbai block done, 14 rows (jobs 77 to 90). Title mix: Data Analyst 5, Fresher/Junior DA 2, Business Analyst 2, MIS 3, Operations 1, off-plan 1. Searches ran short on Fresher, BA and Operations postings; no padding with off-target rows.

### Day 3, Naukri, Delhi/NCR block (jobs 91 to 104)

- Delhi/NCR block done, 14 rows. Title mix: Data Analyst 5, Fresher/Junior DA 1, Business Analyst 4, MIS 3, Operations 0, off-plan 1. Operations Analyst postings are very thin across the Naukri blocks so far (jobs 58, 71, 87), which weakens Question 5.
- Duplicate check on jobs 1 to 104: 0 pairs found.
- Job 91 (Giit): headline "Data Analyst", Role "Data Engineer", ETL/Spark/Kafka work; off-target, exclude candidate. Description requires a 2-year agreement and graduation in 2023 or earlier, against portal experience 0 - 1 years.
- Job 104 (American Express): Model Risk Management, GenAI/LLM model validation; off-target, exclude candidate. Description asks for an MBA or Master's from a top-tier institute, portal says Any Graduate.
- Job 93 (Nxtwave): 2.5-year service agreement with payback clause; graduation-year and B.Tech/MCA gate in the description, portal education says Any Graduate. Borderline. Phase 3 idea: extract a bond/service-agreement flag.
- Job 99 (MBS Global): portal salary 20-35 Lacs P.A. with experience 0 - 6 years (outlier); IT business analyst work; URL says modern-ballistic; BI/Tableau tags not in description.
- Job 92 (Legistify): portal experience 0 - 2 years but URL says 0-to-1-years; check against the posting. Data-administration work; URL ID points to Nov 2024.
- Job 97: posted_ago "Today" but URL ID points to 22 May 2026 (refreshed posting). Education field is a very long list of engineering branches.
- Jobs 101 and 102: identical skills_portal lists generated from the Naukri MIS template; tags are uninformative.
- Job 100: headline "Business Analyst", description asks for a Data Analyst at Broadway; "12 years" is a lost dash (1-2).
- Job 94: description cut off mid-word ("turnaroun") with a stray "Role & responsibilities" heading. Company shown as "Client of Markmakers" (URL says mark-makers-consultancy-services).
- Job 96: company shown as "Manufacturing Firm (Undisclosed)" (URL says good-hr-services); headline contains pipe characters.
- Company names differ from URL names on jobs 99 (modern-ballistic) and 103 (Spar vs sapere-krognos).
- Relevance sort again returns old postings: jobs 92, 101 and 102 have URL IDs from 2024 to 2025.

### Day 3, Naukri, Bangalore second pass (jobs 105 to 108)

- Job 105 (Hexira Digital): words in the description are run together where line breaks were lost ("businessrequirements", "dataanalysis"); skill extraction in Phase 3 needs to handle this.
- Job 106 (Integrated Wireless Solutions): headline MIS Executive, Role field "Leadership Recruiter", department Human Resources; description is MIS and billing work.
- Job 107 (Paakashala): skills_portal (CAPA, GMP, OOS, QMS, TrackWise) does not match the description (business and sales reports).
- Job 108 (Olive Crypto): headline "Operations Analyst", city field Hyderabad, work is UPI payment reconciliation; Role field "Management - Other"; accounting-style work, exclude candidate.
- Naukri Operations Analyst postings are rare across all cities (jobs 58, 71, 87, 108; only job 58 is clean). Operations comparison for Question 5 to be filled from LinkedIn and Indeed.
- Bangalore second pass done, 4 rows (jobs 105 to 108; planned 6); searches for Operations Analyst, Business Analyst and MIS in Bangalore returned no further on-target postings. Title mix: Business Analyst 1, MIS 2, Operations 1.
- Duplicate check on jobs 1 to 108: 0 pairs found.
- Naukri closed at 99 rows (including 4 pilot rows), target 100.

### LinkedIn, Bengaluru block (jobs 109 to 119)

- LinkedIn Bengaluru block: Date posted filter was not applied (jobs 111 and 118 are 6 and 3 months old); Experience level filter not used except for the entry-level retry.
- LinkedIn postings in this block skew senior: jobs 109, 110, 112 ask for 3+ years; only job 113 (Schneider, "Business Analyst I", no years stated) is clearly entry-level. LinkedIn has no experience field; extract from description in Phase 3.
- LinkedIn Bengaluru block done, 11 rows (jobs 109 to 119). Title mix: Data Analyst 3, Business Analyst 3, Operations 1, MIS 1, entry-level 3 (jobs 117 to 119). No posting titled Junior or Fresher Data Analyst was found; entry-level roles appeared as Associate Consultant and Intern titles. Operations and MIS searches returned few postings, mostly off-target.
- Salary format on LinkedIn: "400K INR/yr - 800K INR/yr" (job 111). Parsing rule needed in Phase 3 (400K = 4 LPA). Job 111 description starts with scraped company metadata (Website, Business Type, Funding Stage, Salary Range); strip in Phase 3.
- Job 110 (Sutherland): description says "Experience: 5 -10 years" and lists Hyderabad, Mumbai, Chennai and Bangalore; it ends with a "Requirements added by the job poster" block (4+ years MySQL, PostgreSQL, Databases), which is LinkedIn screening text, not the description; strip before extraction.
- Jobs 110 and 112: words glued where line breaks were lost ("Job DescriptionAs a", "Key Skills RequiredExperience"). Same as job 105 on Naukri; skill extraction must handle it.
- Job 116 (Hector Beverages): description ends with empty template headings (Designation, Function, Sub-function and so on); strip in Phase 3.
- Job 117 (Huron): headline "Associate Consultant - Analytics", description says "Oracle Analyst" (Oracle ERP implementation and reporting); 2025-2026 batch preferred; minimum 60% academic cutoff (55% for Maharashtra candidates). Borderline.
- Job 118 (Portcast): internship, posted 3 months ago; description asks for prior internship experience in a Data Analyst or Business Analyst role.
- Job 119 (ShareChat): internship; salary shown as "50K INR/month" (a stipend). Keep internships out of the salary analysis, or parse them separately (monthly, not annual). LinkedIn has no employment-type field, so identify internships from the title in Phase 3.
- posted_ago on LinkedIn includes "Reposted 1 week ago" and "Reposted 2 weeks ago" (jobs 112, 114, 115); derive a reposted flag in Phase 3.
- Applicants on LinkedIn: "66 people clicked apply" (job 109), "Over 100 applicants" or "Over 100 people clicked apply" (cap); treat only as a 100+ flag.
- Job titles on jobs 109, 115 and 116 have a trailing space; trim in Phase 3.
- Duplicate check on LinkedIn rows (ID after currentJobId=): 0 pairs among 15 rows.

### LinkedIn, Hyderabad block (jobs 120 to 131)

- Hyderabad block done, 12 rows (jobs 120 to 131). Title mix: Data Analyst 4, Business Analyst 3, entry-level (Associate or Intern) 3, Operations 1, MIS 1. Date posted filter not used (too few postings with it); posted_ago runs from 1 week to 4 months, filter in Phase 3.
- Seniority: only jobs 125 (under 2 years) and 130 (intern, 0 to 6 months) are clearly entry-level. Job 126 "Associate" asks 3 to 5 years; job 122 "Data Analyst" asks 7+ years; job 127 asks 7.5 years (ServiceNow).
- Job 120 (Syneos): headline "Data Analyst I", city shown as Serilingampalli, Telangana; work is ADF/Databricks data engineering, DP-203 certification, EST shifts; off-target, exclude candidate.
- Job 126 (Amgen): headline "Associate Data Analytics", description is data quality and governance, 3 to 5 years; borderline.
- Job 123 (vidaXL): portal work mode On-site, description says semi hybrid (4 days office); words run together where line breaks were lost.
- Job 130: company shown as "Leadrat Real Estate CRM - Dubai | India", description says Dhinwa Solutions Pvt. Ltd.; city "Greater Hyderabad Area"; internship; description ends with a "Skills:" line.
- Job 131: description says 3-5 years and "Must have 3-6 years"; night shifts.
- Jobs 124, 125 and 115: LinkedIn appends "Benefits found in job post" to the description; strip in Phase 3.
- Jobs 125 and 131: email address in description replaced with [removed]. Job 128 title and job 129 company cells had line breaks; cleaned.

### LinkedIn, Pune block (jobs 132 to 146)

- Pune block done, 15 rows (jobs 132 to 146). Jobs 141 (Navi Mumbai), 144 (Mumbai) and 146 (Navi Mumbai) have Mumbai city fields, so Pune proper is 12 rows. Title mix by actual title: Data Analyst 5, Business Analyst 3, Associate 2 (136, 146), Intern 3 (142, 143, 144), Operations 1 (145), MIS 1 (137). No Operations Analyst titles found in Pune; "Business Operations Intern" and "Operations Support Analyst" used instead.
- Seniority: all three BA postings are senior (138: 5 to 10 years; 139: AVP; 140: 6+ years). Entry-level roles are the interns, job 136 (0 to 2 years) and job 145 ("Ops Sup Analyst 1").
- Job 141 (Zema Global): same posting as Naukri job 77 (same company, title and description); cross-portal duplicate, collapse in Phase 3 by company, title and city. Its URL carries a salary filter parameter (f_SAL), so a salary filter was active for that search (breaks the no-filter rule; see Limitations).
- Job 140 (SailPoint): email address in description replaced with [removed]; "Sr. Business Analyst", 6+ years; words glued where line breaks were lost; applicants "79 people clicked apply" (below the 100 cap).
- Job 133 (Wynisco): reposted 3 months ago; description starts with scraped company metadata (Website, Business Type, Funding Stage), same as job 111.
- Job 137 (Mercedes-Benz dealership): MIS role that includes lead and DMS data entry; description ends with empty template headings.
- Job 143 (Celoxis): internship, stipend shown as "20K INR/month - 25K INR/month"; keep out of annual salary analysis. Words glued where line breaks were lost.
- Job 146 (Mastercard): headline "Associate Analyst", work is KPI monitoring and incident management on 24x7 rotational shifts, 1 to 3 years; not counted as Operations.
- Job 136 (Blue Matter): description ends with a website, "Powered by JazzHR" and a stray code; strip in Phase 3.
- Job 139 (Deutsche Bank): AVP-level "Business Functional Analyst".

### LinkedIn, Chennai block (jobs 147 to 159)

- Chennai block done, 13 rows (jobs 147 to 159). Title mix by actual title: Data Analyst 4, entry-level 3 (151 "Jr Data Analyst", 158 "Associate Data Analyst", 159 Intern), Business Analyst 3, Operations 1 (155), MIS 2 (156, 157).
- Job 159 (Portcast) is a repost of job 118 (Bengaluru) and job 155 (Citi) is a repost of job 145 (Pune): same company, title and description, different URL IDs and cities; collapse in Phase 3.
- Job 149 (Emarlex): headline "Data Analyst", description is Snowflake/SSIS/Informatica data engineering and ends with "ETL Developer"; scraped web text at the top; salary in the description (12 to 15 LPA) while the portal field is Not disclosed. Off-target, exclude candidate.
- Job 156: "MIS Analyst (FP&A)" requiring a Chartered Accountant; finance role, exclude candidate; company shown as "People, Jobs, and News" (aggregator). Description ends with an appended "Skills:" line.
- Job 158 (Teamware): "Data Steward/Associate Data Analyst", CRM/MDM data maintenance and cleansing; borderline; "Requirements added by the job poster" block (2+ years) is LinkedIn screening text, strip before extraction. Job 148 has the same kind of block.
- Job 147: company shown as Wayfair but the description says OJ Commerce; reposted 7 months ago; description starts with scraped company metadata (Business Type, Funding Stage, Salary Range).
- Seniority: only job 159 (intern) is clearly a fresher role. Job 151 "Jr Data Analyst" asks 2 to 4 years; job 150 describes a junior role but asks 5+ years; job 158 "Associate" asks 2+ years; job 153 "BA" asks 10 to 12 years; job 154 asks 5+ years.
- Job 154 (OneMagnify): description still contains a placeholder where the benefits section should be ("[Insert standard OneMagnify Benefits section...]").
- Salary formats on LinkedIn include "K INR/yr", "M INR/yr" (job 147: 500K - 1.7M, job 156: 1M - 1.5M) and "K INR/month" (stipends, jobs 119 and 143); one parsing rule needed in Phase 3.
- Words glued where line breaks were lost on jobs 148, 153 and 157.

### LinkedIn, Mumbai block (jobs 160 to 171)

- Mumbai block done, 12 rows (jobs 160 to 171); with jobs 141, 144 and 146 that makes 15 Mumbai-area LinkedIn rows. Title mix by actual title: Data Analyst 2, Associate-titled 4, Business Analyst 2, Operations 1, MIS 1, other 2 (161 Risk Analyst, 169 Business Insights Analyst).
- Job 170 (PivotRoots) is the same posting as Naukri job 82 (Havas Media); cross-portal duplicate, collapse in Phase 3. Jobs 160 and 164 (IDFC FIRST Bank, Cx and Collections) share a near-identical template for two business units; separate postings.
- Job 161 (Experian): "Risk Analyst - Data Science & Analytics", predictive modelling and ML, 3+ years; off-target and off-plan title, exclude candidate.
- Job 165 (JPMorgan): FP&A, US GAAP and month-end close work, 5+ years; finance role, exclude candidate.
- Job 168 (Axis Finance): "Business Analyst" in name only (deal structuring, client relationships, covenant monitoring, audits); posted 3 months ago; exclude candidate.
- Job 163 (BlackRock): "Associate" title but 5+ years, analytics engineering and BI; borderline.
- Seniority: only job 170 (0 to 2 years) and job 167 (1 to 3 years) are junior; three of the four Associate-titled rows ask 3 to 5+ years. No interns in this block.
- Job 166 (Media.net): title has a requisition number appended; description has words glued together throughout; "Requirements added by the job poster" block to strip.
- Job 169 (TaskUs): description says "Posted At: Wed Sep 23 2026" while LinkedIn says "Reposted 1 day ago"; refreshed posting.
- LinkedIn city formats vary: "Mumbai Metropolitan Region", "Navi Mumbai", "Pune Division", "Pune City", "Pune District", "Pune/Pimpri-Chinchwad Area", "Greater Hyderabad Area", "Serilingampalli, Telangana"; standardize in Phase 3.

### LinkedIn, Delhi/NCR block (jobs 172 to 184)

- Delhi/NCR block done, 13 rows (jobs 172 to 184): 10 Gurugram, 3 Delhi (182, 183, 184), none from Noida. Title mix by actual title: Data Analyst 3 (177, 178, 183), entry-level 4 (173 Associate Analyst, 174 Jr Data Analyst, 176 Associate Data Analyst, 184 Business Analyst Intern), Business Analyst 3, Operations 1 (181), MIS 1 (182), other 1 (172 Lead Analyst).
- Seniority: this block has the most junior roles so far: jobs 173 (freshers and up to 2 years), 174 (1 to 2 years), 183 (0 to 3 years, new graduates welcome) and 184 (intern). Job 176 "Associate" asks 2 to 5 years with VBA and Python mandatory; job 178 asks 5+ years.
- Job 181 (Quantiq): "Market Operations Analyst", live trading monitoring on EST sessions; trading operations rather than data analysis; borderline; posted 3 months ago.
- Job 172 (American Express): "Lead Analyst", MIS reporting and workload tracking for partner risk monitoring; the EEO paragraph appears twice; borderline.
- Job 184 (Skillzen Loop): portal work mode On-site and city Delhi, description says "Workplace Type: Remote"; stipend INR 10,000 to 12,000 per month for a 1 to 3 month internship.
- Job 182 (Natural Life Style): very long MIS role mixing hospital, donor, camp and social media data; posted 2 months ago.
- Job 177 (EXL): description is two paragraphs with no requirements; experience not stated.
- LinkedIn appends a "Skills:" line to some descriptions (jobs 130, 156, 174, 175); keep as part of the description; it is not in skills_portal.
- LinkedIn closed at 80 rows (including 4 pilot rows).
- Duplicate check on all Naukri rows and all LinkedIn rows, run separately per portal (Naukri: URL text before the "?"; LinkedIn: currentJobId): 0 duplicate pairs. Cross-portal duplicates are not covered by this check and are handled in Phase 3 (see the list above).

### Indeed, Bengaluru block (jobs 185 to 196)

- Indeed Bengaluru block done, 12 rows (planned 10). Title mix by actual title: Data Analyst 5, Business Analyst 2, Associate 1 (191), Operations 1 (192), MIS 3 (193 to 195). No Junior, Fresher, Trainee or Intern titles. Job 188 has "(0 - 1 Year)" in the title but does not match the entry-level title rule; decide in Phase 3.
- Searches used: "data analyst fresher" (jobs 185 to 190), "data analyst intern" (191, 192), "mis executive" (193 to 195), "data analyst" (196), location Bangalore City, radius 25 (default). The "fresher" keyword returned roles asking 2 to 5 years, so Indeed rows from keyword searches do not reflect a clean fresher group. From Hyderabad on, plain titles are searched for Data Analyst, Business Analyst, MIS and Operations, and fresher/junior/intern keywords only for the entry-level slots.
- URLs copied from the search page carry vjk= (viewed job key) instead of jk=; same value. The duplicate formula looks for "jk=" and works for both: =MID(L2,FIND("jk=",L2)+3,16).
- Salary shown on 2 of 12 rows (193, 194), both MIS Executive. Formats: "₹25,000 - ₹50,000 a month" and "₹4,00,000 - ₹5,00,000 a year" (Indian digit grouping). One parsing rule needed in Phase 3 (monthly x 12, then divide by 100,000).
- Indeed has no experience field and no skill tags: experience_portal is Not mentioned and skills_portal is No tags for all rows. Work mode shown on 1 row (196, "Hybrid work").
- Job 186 (Cognoid): headline "DATA ANALYST", work is manual and automation testing (Selenium, JMeter); off-target, exclude candidate. Description has check-mark symbols and no requirements section.
- Job 189 (GetixHealth): Business Analyst, healthcare payment reconciliation (Epic, revenue cycle) with SQL and Excel; borderline. City field is only "Karnataka".
- Job 192 (Instawork): Product Operations Analyst, mostly automation (n8n, Zapier) and data quality; borderline. Company shown as "Instawork Internal"; US-focused company text.
- Job 193 (Assettrust): MIS Executive mixed with sales coordination and flat handover paperwork; borderline. Description ends with an Indeed block (Education: Bachelor's, Experience: Sales analysis 1 year Required, Work Location: In person) and repeats the salary. Company shown as "Assettrust Services", description says "Asset Trust Services".
- Job 194 (Apna): title "MIS Executive- Bangalore", description title "Business Analyst (MIS)", 2 to 4 years, SQL and data pipelines; city in the title.
- Job 195 (Avery Dennison): "Operations MIS - Data Analyst", 3 to 4 years; description says "Work model: On-site" while work_mode_portal is Not mentioned. City field is a street name.
- Job 190 (Thoucentric): description starts with a "Job Information" table (Required Skills cut off, "Date Opened 04/09/2025", Work Mode Hybrid); the same description asks "3-5 years" and "2-4 years". Date format ambiguous; probably an old posting.
- Job 187 (Garuda Aerospace): description starts with "Bangalore, Chennai" and a "Sales & Business Development" line; 2 to 3 years (en dash). Expect it again in the Chennai block.
- Job 188 (Informica Solutions): description cut off mid-sentence, one bullet repeated, hard line breaks; URL ends with a stray backslash (removed).
- Job 191 (PhonePe): city field is a full office address; description has long company and benefits boilerplate; 0.5+ years.
- Job 196 (GoTymeX): "Requirements" heading appears twice; asks 2+ years in financial services and mentions GDPR.
- Experience in this block: only 191 (0.5+) is entry-level; 187, 190, 194, 195, 196 ask 2 or more years; 185, 186, 189, 192 state no years.
- City formats on Indeed: "Karnataka", street names, area names ("HSR Layout") and full addresses; standardize in Phase 3.
- Duplicate check on Indeed rows (jk/vjk value, helper-column formula, including the 2 pilot rows): 0 duplicate pairs. Cross-portal duplicates are not covered by this check and are handled in Phase 3.
- Indeed shows no posted_ago on the postings, so posted_ago is Not mentioned for all Indeed rows. Posting age cannot be filtered for Indeed in Phase 3; only dates that appear inside a description (for example job 190, "Date Opened 04/09/2025") are usable. Indeed rows may include old postings, which overstates current openings.

### Indeed, Hyderabad block (jobs 197 to 206)

- Indeed Hyderabad block done, 10 rows (planned 9). Title mix by actual title: Data Analyst 4, Business Analyst 2, Junior or Associate or Fresher-titled 3 (200, 201, 205), MIS 1 (204), Operations 0.
- Search queries: "data analyst" (jobs 197 to 203), "mis executive" (204), "associate data analyst" (205), "data analyst intern" (206). Business Analyst jobs 198, 201 and 202 and the Implementation Analyst job 200 came from the "data analyst" search, not from a "business analyst" search, so they were not sampled by title; the same holds for Bengaluru jobs 188 and 189. From Pune onward, Business Analyst rows come from a "business analyst" search.
- Experience_portal shows "Fresher" on jobs 200 and 202 (first Indeed rows with a value); copied as shown. Work mode shown on job 203 ("Remote"). Salary shown on jobs 202 and 204.
- Job 202 (srinivasa traders): headline "Business Analyst", description "Junior Business Analyst" for software requirements work (BRD, FRD, UAT), SQL only an advantage; portal salary "₹4,19,000 - ₹6,40,000 a year" (Indian grouping) while the description says "₹419,000.00 - ₹640,000.00 per year"; high for a fresher role, check as outlier in Phase 3; company name in lowercase; email replaced with [removed]; "Work Location: In person" appears twice.
- Job 204 (Aditya Music): salary_portal ₹18,000 - ₹25,000 a month (first entered as Not disclosed by mistake, corrected after checking the posting header against the description). Company name has " – Hyderabad" appended.
- Job 203 (Tribute Technology): headline "Data Analyst", description says "Senior Analytics professional" and 7+ years; fully remote role ("Fully remote across India", #India-remote), so the Hyderabad city tag is the search location. Phase 3 needs a rule for remote postings and city.
- Job 206 (Tanla Platforms): headline "Data Analyst", 5 to 7 years, found through the "data analyst intern" search; zero-width characters and an empty "Job Role" heading in the text.
- Job 197 (Alpha Terra): headline "Data Analyst", description title "Data Analytics", "minimum one year working eperience" (typo), asks for ML models (Decision Tree, Random Forest) and collecting data from Magicbricks and OLX; pay "Based on skills & learning curve" in the description; "Work Location: In person" twice; city field includes the area "Banjara Hills".
- Job 198 (Caribou Media): software Business/Systems Analyst with QA and partner integration; SQL one of many requirements; borderline. No years stated.
- Job 199 (Saaki Argus & Averil Consulting): Power BI, DAX, SQL and Power Query responsibilities only; no requirements section, no experience, employer not named.
- Job 200 (ZeroCodeHR): "Implementation Analyst (Fresher)", software implementation, QA and SQL reporting, 0 to 1 years; off-plan title, borderline. Encoding glitches in the text (customerâ€™s, clientâ€™s, Bachelorâ€™s); fix in Phase 3, not in the raw sheet.
- Job 201 (Irish Expert): "Junior Business Analyst – NCO (B2B)", immigration and consulting firm, sales and business analysis, 0 to 2 years; SQL, Power BI and Tableau only "preferred".
- Job 205 (TriNet): "Associate Data Analyst", data entry, reconciliation and routine reporting, "Typically < 2 years" (needs a "less than" parsing rule); long diversity and EEO boilerplate; email replaced with [removed]; description says 100% in office while work_mode_portal is Not mentioned.
- Experience in this block (description): 200 (0 to 1), 201 (0 to 2), 202 (fresh graduates) and 205 (< 2) are entry-level; 197 and 204 ask 1 year; 203 asks 7+ and 206 asks 5 to 7; 198 and 199 state no years. No clean fresher Data Analyst posting.
- No Operations Analyst posting collected in Hyderabad: the "operations analyst" search returned no on-target postings.
- Duplicate check on all Indeed rows (jk/vjk value, Bengaluru plus Hyderabad, 24 rows including the 2 pilot rows): 0 duplicate pairs.

### Indeed, Pune block (jobs 207 to 216)

- Indeed Pune block done, 10 rows (planned 9). Title mix by actual title: Data Analyst 4 (207 to 210), Business Analyst 2 (211, 212), Operations 1 (213), MIS 1 (214), Intern 2 (215, 216). No Junior, Fresher, Trainee or Associate titles.
- Search queries: "data analyst" (207 to 210, taken from result pages 2 to 8, start=10, 20, 60 and 70, not the top results), "business analyst" (211, 212, page 3), "operations analyst" (213), "mis executive" (214), "associate data intern" (215, 216), location Pune, Maharashtra, radius 25. Business Analyst rows were sampled by a "business analyst" search as planned.
- Salary shown on 6 of 10 rows (208, 209, 210, 214, 215, 216), far more than in the earlier Indeed blocks. Formats: annual with Indian grouping (210: "₹3,00,000 - ₹5,00,000 a year"), open-ended ("From ₹25,00,000 a year", job 208, description says "Budget: 25–26 LPA"), monthly (209, 214, 215, 216). Descriptions repeat the pay with western grouping and ".00". Parsing rule for Phase 3: strip the symbol, commas and ".00"; "From" means minimum only; monthly x 12, then divide by 100,000. Jobs 215 and 216 are internships (stipends), excluded from salary analysis.
- Job 208 (Clock Edge Technologies): contract Qlik Sense developer, 9 to 12 years, "Contract basis third party payroll artech" and a staffing requisition ID in the text; 25+ LPA is an outlier; company name truncated ("Pvt Lt"); title "Data Analytics". On-target work, senior, staffing-agency posting.
- Job 207 (Hexanika): 3+ years, SQL, data modelling and test-data work in the BFS domain; header says "Role & Responsibilities" but holds requirements; typo "Wellworsed"; email replaced with [removed].
- Job 209 (Nyati Technologies): title "Data analytics" in lowercase; city field has "Ajmera Morwadi Road, Pimpri, Pune"; description has responsibilities only, no experience; pay repeated in the description.
- Job 210 (Foxberry Technology): title "Data Analyst-2+year" (experience in the title, description states no years); city "Pimpri-Chinchwad"; "Knowledge of Marathi is essential"; work includes digital marketing and social media campaign reporting.
- Job 211 (AlphaSense): "Business Analyst II", content strategy and due diligence work, the description calls the role "Content Analyst", 3+ years, SQL/Python only "ideally some"; long fraud-warning paragraph with an email replaced by [removed]; "II" is not an entry-level marker; borderline.
- Job 212 (Netrix Global): "Business Analyst, Service Desk Reporting & Analytics", ServiceNow and Power BI/DAX, 5+ years, shift 1 PM to 11 PM IST; description says the role can be remote with some travel; email replaced with [removed]; company website link in the text.
- Job 213 (Madison Logic): "Revenue Operations Analyst", Sales Ops and GTM reporting (Looker Studio, Snowflake, Salesforce), 2+ years, US-based team; found through the "operations analyst" search but not classic operations; decide in Phase 3 whether it counts in the Operations group for Question 5. Non-breaking hyphens (‑) in the text, doubled quotation marks, long company and privacy boilerplate, hybrid and remote text while work_mode_portal is Not mentioned.
- Job 214 (MBWortld Exim): generic MIS definition with citation markers ([1]) throughout, lists ChatGPT/Claude, Zapier and Apps Script as skills; salary range ₹11,000 - ₹32,000 a month is very wide; portal experience "Fresher"; city Pimpri-Chinchwad; company name typo "MBWortld". Low-quality posting; strip the [1] markers before skill extraction.
- Job 215 (Infyco Technology): Data Analyst Intern, 3 to 6 months, stipend ₹12,000 - ₹26,000 a month; asks for students or recent graduates, no years stated; stipend range is wide.
- Job 216 (We-intern): headline "Data Analyst Intern", but the description is a template for a full-time "Data Analyst", 0 to 2 years, with an unfilled "Location: [Location / Remote]"; portal experience "Fresher"; pay ₹10,000 - ₹20,000 a month; "Work Location: Hybrid remote in Pune". Internship status taken from the title in Phase 3.
- Experience in this block (description): 207 (3+), 211 (3+), 212 (5+), 208 (9 to 12) and 213 (2+) are experienced; 209, 210, 214 and 215 state no years; 216 says 0 to 2. No clean fresher Data Analyst posting.
- Duplicate check on all Indeed rows (jk/vjk value, 34 rows including the 2 pilot rows): 0 duplicate pairs.

### Indeed, Chennai block (jobs 217 to 225)

- Indeed Chennai block done, 9 rows. Title mix by actual title: Data Analyst 3 (217 to 219), Business Analyst 1 (220), Business Analytics Analyst 1 (221), MIS 2 (222, 225), Operations 1 (223, Revenue Operations), Intern 1 (224). Entry-level: 1 row against 2 planned; MIS: 2 rows against 1 planned.
- Searches: "data analyst" page 1 (217 to 219), "business analyst" pages 2 and 3 (220, 221), "mis executive" (222, 225), "operations analyst" (223), "data analyst intern" page 2 (224). Location Chennai, Tamil Nadu, radius 25.
- MIS Executive rows are 7 of the 41 non-pilot Indeed rows (jobs 193, 194, 195, 204, 214, 222, 225), above the planned 1 per city (3 in Bengaluru, 2 in Chennai). MIS searches returned many on-target postings on Indeed, while Operations Analyst searches returned few (only Revenue or Product Operations roles: jobs 192, 213, 223). This reflects quota choices and search supply, not market share. Cap MIS at 1 per city from Mumbai.
- Salary shown on 5 of 9 rows (219, 220, 222, 224, 225). New format: "Up to ₹4,80,000 a year" (219), a maximum only; parse as max with no min. Job 224 is a stipend and is excluded from the salary analysis.
- Job 217 (Infinity crest group): description says "Experience: Fresher" while the title and portal do not; first clean fresher Data Analyst on Indeed, so it counts for Question 4 as entry-level by description. "Responsibilities Requirements" heading merges two sections; em dash in the text.
- Job 218 (Moving walls): "Data Analyst", but the work is audience measurement and statistical modelling (weighting, sampling, forecasting), 2+ years in advertising or media research, includes web scraping, says "lead the team"; borderline. Company website link in the text.
- Job 219 (Tint Tone and shade): generic template description, 1 to 3 years, salary "Up to ₹4,80,000 a year".
- Job 220 (NTN NEI Manufacturing): headline "Business Analyst", software and process analysis (requirements, systems), Excel, SQL, Tableau and Power BI as one bullet; portal experience Fresher, no years in the description; description starts mid-thought with no intro and has inline "•" bullets; company in lowercase; borderline.
- Job 221 (Intigniz Solutions): "Business Analytics Analyst", Role "Team Manager", ML and statistical modelling, SAS, Adobe Analytics, P&L forecasting; 2 to 5 years and "Bachelor's with 3 years OR Master's with 2 years"; off-target (same kind as Experian job 161), exclude candidate.
- Job 222 (futurecalls technology): MIS Executive, description is only a skills paragraph with inline "•" bullets, no duties and no experience; portal experience Fresher; company in lowercase.
- Job 223 (SurveySparrow): second Revenue Operations Analyst (after job 213), CRM admin, lead routing, n8n/Zapier and LLM automation, 1 to 3 years, "a builder role, not a reporting seat"; borderline.
- Job 224 (Cornixe): "Data Science and Business Analytics Intern", a 1-month edutech internship programme with a performance-based stipend of ₹5,000 - ₹15,000 a month; reads like a training programme; description says "Work Mode: Hybrid" while work_mode_portal is Not mentioned; city field starts with the area "Kottivakkam". Stipend excluded from salary analysis.
- Job 225 (Royal Land and Developers): MIS Executive for real estate, "3–5 years of MIS experience", ₹35,000 - ₹40,000 a month; typo "Chennnai", unclear "BSF".
- Experience in this block (description): 217 (Fresher), 224 (freshers and students) and 220 and 222 (portal Fresher, no years stated) are entry-level; 219 and 223 ask 1 to 3; 218 asks 2+; 221 asks 2 to 5; 225 asks 3 to 5.
- Dash and bullet formats vary (en dash 3–5 and 1–3, hyphen 1-3, em dash, inline "•"); the experience parser needs all of them.
- Duplicate check on all Indeed rows (jk/vjk value, 43 rows including the 2 pilot rows): 0 duplicate pairs.

### Indeed, Mumbai block (jobs 226 to 233)

- Indeed Mumbai block done, 8 rows (planned 9). Title mix by actual title: Data Analyst 3 (226 to 228), Business Analyst 1 (229), MIS 2 (230, 231), Associate 1 (232), Trainer 1 (233). No Operations Analyst, Intern, Junior or Fresher titles.
- Searches: "data analyst" page 1 (226 to 228), "business analyst" page 3 (229; only one on-target Business Analyst found), "mis executive" pages 1 and 2 (230, 231), "associate data analyst" (232), "data analyst intern" page 4 (233; no intern titles found), "operations analyst" (no on-target postings found). Location Mumbai, Maharashtra, radius 25.
- MIS cap of 1 per city was broken again (2 MIS rows); MIS rows were then 9 of the 49 non-pilot Indeed rows (jobs 193, 194, 195, 204, 214, 222, 225, 230, 231). After Delhi/NCR: 10 of 60.
- Job 233 (Gigatorb): Data Science & Data Analytics Trainer in Thane, 5 to 6 years, "Full-Time / Part-Time / Contract / Freelance", ₹40,000 - ₹60,000 a month; teaching role found on the intern search; off-target (same as pilot job 10), exclude candidate. City field is Naupada, Thane, not Mumbai.
- Job 231 (Moksha Retails Global): headline "Senior MIS Analyst", description "MIS & Business Analyst", 8 to 10 years, strong BI and AI knowledge, 6 days a week, ₹50,000 - ₹60,000 a month; email appeared twice and the second one was missed at first (replaced with [removed] afterwards); headings glued together ("Key ResponsibilitiesMIS and reporting"); company shown as "Moksha Retails Global Pvt Ltd", text says Unione Group and Moksha Enterprises.
- Job 226 (Sia): headline "Data Analyst", description "Power BI Developer", 3 to 6 years, mandatory PL-300, internal Finance and HR reporting; city field is a street address (Supreme Business Park, Hiranandani Gardens).
- Job 227 (Sounce Retail): "Data Analyst", description says 0 to 6 months and portal says Fresher, ₹10,000 - ₹15,000 a month; second clean fresher Data Analyst on Indeed after job 217. City field "Chinchpokli".
- Job 228 (Unistanz Software): 3 to 5 years, Advanced Excel and macros, ₹5,00,000 - ₹7,00,000 a year; description ends with an Indeed "Application Question(s)" block (numbered 2 to 10, then 1) asking current salary and notice period, strip in Phase 3; role overview repeated twice; company website link in the text.
- Job 229 (MobileProgramming): "Business Analyst (BA)", software requirements work (BRD, FRD, JIRA, UAT), 5+ years, "Basic SQL, Data Analysis" as one skill; sentences run together where line breaks were lost; borderline.
- Job 230 (Emgage): MIS Executive, 2 to 4 years; description is only an experience and skills fragment ending with a "Skills:" line, no responsibilities.
- Job 232 (Games2win): "Associate Analytics" asks "Minimum 2+ Years" and also "at least 1 year" in a technical or analytics function; BigQuery, Excel, SQL; reports to the Head of Revenue; company website link in the text. Entry-level title with an experienced requirement (Question 4).
- Salary shown on 4 of 8 rows (227, 228, 231, 233); job 233 excluded with the trainer role.
- Experience in this block (description): 227 (0 to 6 months) is entry-level; 230 asks 2 to 4, 232 asks 2+, 226 asks 3 to 6, 228 asks 3 to 5, 229 asks 5+, 231 asks 8 to 10, 233 asks 5 to 6.
- Duplicate check on all Indeed rows (jk/vjk value, 51 rows including the 2 pilot rows): 0 duplicate pairs.

### Indeed, Delhi/NCR block (jobs 234 to 243)

- Indeed Delhi/NCR block done, 11 rows (planned 9); Indeed closes at 62 rows. Title mix by actual title: Data Analyst 3 (234 to 236), Business Analyst 4 (237 to 240), MIS 1 (241), Junior or Fresher 2 (242, 243), Operations 0. City mix: Delhi 4 (234, 238, 240, 241), Noida 3 (235, 239, 243), Gurugram 4 (236, 237, 242, 244).
- Searches: "data analyst" (234 to 236, in Delhi, Noida and Gurugram), "business analyst" (237 to 239, 238 from page 2), "mis executive" (240 in Delhi, 241 in Gurugram), "associate data analyst" (242, Gurugram); job 243's search was not visible in the paste. Location strings were typed "Delhi, Delhi", "noida", "Gurugram, Haryana", "delhi", "gurugram"; jobs 234 and 240 have no radius in the URL.
- Emails: job 237 had an unremoved email and job 238 had the domain "@alpha-sense.com" (job 211 has [removed]); both replaced after review. Earlier, job 231 also had a missed second email. A full-sheet scan for "@" and long digit strings was run after Indeed closed: replaced all mails with [removed].
- Job 238 (AlphaSense) is the same posting as Pune job 211 (same title and description, different city and job key); repost within Indeed, collapse in Phase 3.
- Job 234 (WinZO): headline "Data Analyst", description is senior (dbt, Airflow pipelines, A/B-testing platforms, "lead end-to-end projects", "mentor junior analysts"), no years stated; very long company and values boilerplate and a "Download our app" line with joined URLs; non-breaking hyphens throughout; borderline.
- Job 235 (RightWave): 3+ years, B.Tech, BCA, MCA or MTech required; a stuffed "Key Skills" block (PowerBI, My SQL, Google Analytics, DiscoverOrg/ZoomInfo) next to "Key Attributes", so skill extraction will overcount.
- Job 236 (HS Oberoi): company field "HS Oberoi Buildtech Pvt Ltd", text says "H.S. Oberoi Spirits Company"; 2 to 3 years, sales MIS reporting; ₹30,000 - ₹35,000 a month.
- Job 237 (Paramount Energy Solution): Business Analyst for project reporting and MIS in EPC firms, MBA required, 1 to 3 years, "From ₹4,19,000 a year" (same minimum as job 202, possible platform default or estimate; check as a suspect value); ✅ and ✔ symbols in the text.
- Job 239 (vensysco technologies): software Business Analyst (BRD, FRD, SRS), 2 to 3 years, ₹3,60,000 - ₹6,00,000 a year; experience stated in three places; "Work Location" appears twice; borderline.
- Job 240 (Delhi Press): "Business Analyst (MIS & Reporting)" for magazine circulation and sales reporting, 1 to 3 years; city field is "Delhi"; email replaced with [removed]; description starts with "Careers".
- Job 241 (D Succeed Learners): MIS Executive, generic template ("Reports To: MIS Manager / Operations Manager / IT Head"), 2 to 4 years, ₹25,000 - ₹35,000 a month; city "Janakpuri, Delhi, Delhi" although found in the Gurugram search; cell ends with a blank line.
- Job 242 (OcIT): "Data Analyst - Freshers" with portal experience Fresher, but the description asks for insurance reporting experience, "strong experience in Power BI development", the ability to lead a team and CI/CD tools; entry-level label with senior requirements (Question 4).
- Job 243 (Rezo.ai.): "Junior Data Analyst", Zoho-style "Job Information" table ("Date Opened 27/10/2026", "Work Experience 0-1 year", Postal Code 201301); the day is 27, so this template uses day/month/year (suggests job 190's "04/09/2025" is 4 Sep 2025; confirm in Phase 3); company shown as "Rezo.ai." with a trailing full stop.
- Job 244 (PinnacleU): "Business / Data Intelligence Analyst", Gurugram, found through the "data analyst intern" search (URL: radius 25, vjk), collected 9 Nov and not logged at the time; description says "Experience Required: 1-2 years", Monday to Friday; salary "₹19,00,000 - ₹20,00,000 a year" is an outlier for 1 to 2 years, check against the posting in Phase 3. This makes Indeed 62 rows and Delhi/NCR 11.
- Experience in this block (description): 243 (0 to 1) is junior; 242 is labelled Fresher but senior in content; 237 and 240 ask 1 to 3, 236 and 239 ask 2 to 3, 241 asks 2 to 4, 235 and 238 ask 3+; 234 states no years.
- Salary shown on 4 of the 10 rows checked (236, 237, 239, 241); job 243 salary not disclosed, job 244 is shown separately.
- Duplicate check on all Indeed rows (jk/vjk value, 62 rows including the 2 pilot rows): 0 duplicate pairs by key; one repost by description (jobs 211 and 238).

### Foundit layout and Block 1 notes (Bengaluru)

- Foundit shows experience, salary, industry, skills and posted_ago. It has no Role field, no education field, no work mode and no openings count; those columns are Not mentioned. It also shows Function, Job Type and Employment Type, which have no column and are not collected.
- Foundit "Key Skills" block includes profile-dependent text ("4 out of 26 preferred skills are a match", "Remove" labels, "You can add or edit skills in profile page"). Only the tag names are copied to skills_portal.
- Foundit skill tags are copied with a browser console command that finds the "Key Skills" heading and joins the tag text with commas. It skips the profile-dependent lines ("x out of N preferred skills are a match", "Remove", "You can add or edit skills in profile page" and its link text). Tag count is checked against N on the first 3 postings, then spot-checked.
- Foundit applicants field reads "Be among the first 40 applicants", a threshold, not a count; treat as unusable in Phase 3.
- Duplicate check on Foundit rows (numeric job ID at the end of the URL, helper column =MID(L,FIND("&",L&"&")-8,10) plus COUNTIF; assumes an 8-digit ID and no query string, checked with a length and number test): 0 duplicate pairs among 11 rows (jobs 245 to 255). Cross-portal duplicates are handled in Phase 3.

### Foundit, Bengaluru block (jobs 245 to 255)

- Foundit Bengaluru block done, 11 rows (planned 10). Title mix by actual title: Data Analyst 4 (245 to 248), Business Analyst 3 (249 to 251), Associate 1 (254), Intern 1 (255), MIS 1 (252), Operations 1 (253). Job 244 is the Indeed row logged under Indeed Delhi/NCR; Foundit numbering started at 245.
- Foundit salary is Not disclosed on all 11 rows. Foundit shows posted_ago on every row (values: hours, days, "a month ago", "2 months ago"), so posting age can be filtered in Phase 3. Job IDs of the older rows (252, 254, 255) are much lower than recent ones; do not derive dates from Foundit IDs.
- Foundit applicants formats: "Be among the first N applicants", "Over N applicants have applied" (N = 10 to 500). Thresholds, not counts; unusable except as buckets.
- Foundit company names appear in lowercase on some rows (merck group, refyne india, beyond appliances, prosessed). Job 249 and 250 company is shown as "Amazon Alliance" while the descriptions name ASSPL and ADCI.
- Foundit skills_portal tags: casing varies (Sql, Bi Tools, make, google sheets); "Quicksight" and "Quick Sight" both appear. Job 249 has tags with commas inside them ("data visualization tools (e.g., capacity modeling, SQL)"), so skills_portal cannot be split on commas in Phase 3 without care. The tag "make" (job 252) collides with the common word when extracting from text. Job 254 tags (web scraping, CSS selectors, R) are listed although the description says they are "not mandatory".
- industry_type on Foundit shows "Other" on most rows and a real value on some (job 261: Consulting/Advisory Services); mostly uninformative.
- Job 245 (Eurofins): headline "Data Analyst", description title "Power BI Developer", 4+ years, Power BI/DAX/SQL Server plus Python and .NET development; borderline. Long company boilerplate; names an individual (strip before publishing); "Job Description" appears twice.
- Job 246 (merck group): headline "Data Analyst", but the work is Snowflake/dbt data engineering, 5+ years; off-target, exclude candidate. "Who You Are" holds the duties and "Your Role" the requirements; two requirement bullets repeat.
- Job 247 (refyne india): "Data Analyst – Finance", MIS reporting, 3 to 5 years (en dash).
- Job 248 (Ecolab): Power BI analytics, 3 to 5 years; includes ServiceNow ticket handling and onsite and weekend schedule text; EEO boilerplate.
- Job 249 (Amazon Alliance): "Business Analyst II" for long-term capacity planning and forecasting, 3+ years, SQL "preferred"; "II" is not an entry-level marker. Title includes the team name.
- Job 250 (Amazon Alliance): "Business Analyst I, WHS WESE", portal 1 to 3 years, description "1+ years of tax, finance or a related analytical field"; entry-level by the "I" marker but asks for experience (Question 4). Title includes the team name.
- Job 251 (LSEG): headline "Business Analyst", portal experience Fresher, description asks for "solid experience as a Business Analyst" and shows "Career Stage: Senior Associate"; portal and description disagree. Non-breaking hyphens in the text; long boilerplate and a privacy notice.
- Job 252 (beyond appliances): MIS Executive for after-sales, 2 to 4 years, no-code and AI automation mandatory, posted 2 months ago. The description starts with the header run together as one line and uses " -" bullets.
- Job 253 (Delta Capita): "Operations Analyst- FX Options Settlements & Investigations" (no space before the hyphen), settlements and Nostro reconciliation, night shift, 0 to 1 years; finance back-office work, off-target, exclude candidate (same kind as job 108).
- Job 254 (Euromonitor): "Associate Data Analyst", Fresher, market research data work; clean entry-level row. Hyphens are lost inside words ("longterm", "wellwritten", "handson", "factcheck"); skill extraction in Phase 3 must handle this. posted_ago "Posted a month ago" is a new bucket.
- Job 255 (prosessed): "Data Analyst Intern - Excel / SQL", asks for 3rd or final year students from IIT/NIT or equivalent; stipend "Competitive" (no number); description says "Remote / Bangalore" while work_mode_portal is Not mentioned; contact line shows Foundit's own "[Confidential Information]".
- Experience in this block (description): 253 (0 to 1) and 254 and 255 (students or no years) are entry-level; 250 asks 1+; 252 asks 2 to 4; 247, 248 ask 3 to 5; 249 asks 3+; 245 asks 4+; 246 asks 5+; 251 states no years but asks for solid experience.
- No reposts or cross-portal matches spotted by eye; detection is in Pandas.

### Foundit, Hyderabad block (jobs 256 to 264)

- Foundit Hyderabad block done, 9 rows (planned 10). Title mix by actual title: Data Analyst 4 (256 to 259), Business Analyst 2 (260, 261), Operations 1 (262), Associate 1 (263), Intern 1 (264), MIS 0. No on-target MIS Executive postings were found; shortfall accepted.
- Foundit salary is Not disclosed on all 9 rows (0 of 20 Foundit rows so far).
- Foundit drops question marks from descriptions (jobs 260 and 261: "...across the globe What would you do"). Job 260's first paragraph is cut off at "MO", has the literal word "null" before the company line, and repeats "Key job responsibilities".
- New posted_ago formats: "Posted 29 days ago", "Posted 16 days ago", "Posted 17 hours ago", next to "Posted a month ago" and "Posted 2 months ago". The month buckets are coarse; parse them as approximate ages in Phase 3.
- Foundit masks emails in descriptions as "[Confidential Information]" (jobs 255, 263, 267, 301); kept as shown.
- Job 256 (Unison Group New Zealand): headline "Data Analyst/Business Analyst" (two titles), 7 to 9+ years, SAP and non-SAP data analysis with Azure and Databricks; sentences run together where line breaks were lost; typo "adhereing". Senior, on-target.
- Job 257 (Persistent Systems): 5+ years, Power BI and Snowflake; posted 2 months ago.
- Job 258 (Google India): "Data Analyst, Risk", Trust & Safety fraud and abuse analysis, 2 years minimum; "About the jobTrust & Safety" glued.
- Job 259 (vidaXL): 3+ years; description says semi hybrid, 4 days in office, while work_mode_portal is Not mentioned. Probable cross-portal duplicate of LinkedIn job 123 (confirm in Pandas).
- Job 260 (Amazon Alliance): "Business Analyst II, Account Integrity", 5+ years, Tableau, Excel and SQL; company line says "ADCI - Karnataka - A66" while the city field says Hyderabad.
- Job 261 (Swiss Re): "Technical Business Analyst I", portal Fresher, description asks 2 to 3 years of hands-on business and data analysis; entry-level title with an experience requirement (Question 4). QA, UAT and requirements-heavy; borderline. Ends with "#corso", an empty "Keywords:" line and a reference code. Industry shows "Consulting/Advisory Services".
- Job 262 (NextPower Capital): "Sales Operations Analyst", quoting tools and CPQ configuration, not data analysis; borderline for Question 5, same kind as jobs 213 and 223. Experience is alternative ("Bachelor's with 5 years or Master's with 3 years or PhD without experience"), so the experience parser needs a rule. Company shown as "NextPower Capital", description says "Nextpower".
- Job 263 (TriNet): "Associate Data Analyst", portal 2-4 years but description "Typically < 2 years"; cross-portal duplicate of Indeed job 205; 100% in office text.
- Job 264 (WORK ASSIST): data analyst internship on a recruitment platform, "a requirement for one of the Workassist Hiring Partner" (employer unnamed), remote; city Hyderabad is the search location. Description starts with a pasted header block (Work Level, Industry Type: IT Services & Consulting, Function, Key Skills, Education) that disagrees with the portal's industry "Other". Skill tags repeat themselves (Bigdata and Big Data Platforms; BI and Business Intelligence) and miss SQL, which the description requires. Ends with a bit.ly link and a trailing blank line.
- Experience in this block (description): 264 (students or recent graduates) is entry-level; 263 (< 2) and 258 (2) are low; 261 asks 2 to 3 against portal Fresher; 259 asks 3+; 262 asks 3 or 5; 257 and 260 ask 5+; 256 asks 7 to 9+.
- Duplicate check on all Foundit rows (job ID at the end of the URL): 0 duplicate pairs among 20 rows.

### Foundit, Pune block (jobs 265 to 273)

- Foundit Pune block done, 9 rows (planned 10). Title mix by actual title: Data Analyst 4 (265 to 268, 268 is "Marketing Data Analyst"), Business Analyst 2 (269, 270), Operations 1 (271), MIS 1 (272), Intern 1 (273). Entry-level by title: 2 (270, 273). Few fresher roles were found; no clean fresher Data Analyst posting.
- Foundit salary is shown on 1 of 29 rows so far (job 273, "₹ 2.5 - 5 LPA", a training institute's internship ad; excluded from the salary analysis). Format: symbol, space, range, "LPA".
- All 12 Data Analyst-titled Foundit rows so far (jobs 245 to 248, 256 to 259, 265 to 268) have a portal minimum of 2 years or more; none starts at 0 or 1.
- Foundit industry_type values seen so far: Other, Consulting/Advisory Services (job 261), Information Technology (job 273).
- Job 273 description contained a phone number; replaced with [removed] after review, then the Foundit rows were scanned for "@" and long digit strings.
- Job 265 (Cornerstone OnDemand): city field Pune, opening line says "Pune Office", description says "Location: Hyderabad, India"; opening words glued ("aData AnalystThis"); 5 to 7 years (en dash); question marks lost.
- Job 266 (Segula Technologies): HR analytics for a North America HR and recruitment team, 8+ years, shift 2 PM to 11 PM IST, hybrid 2 days (work_mode_portal is Not mentioned); on-target, senior.
- Job 267 (apto solutions - executive search & consultants): recruiter hashtag post with the employer unnamed; says "6+ Years" and "5-8 years" in the same text; contact line masked by Foundit; posted 2 months ago.
- Job 268 (Qualys): "Marketing Data Analyst", 7 to 10 years, marketing operations and funnel analytics (Salesforce, Tableau, Power BI, SQL, CQL). The text uses "SQL" for "Sales Qualified Lead" (SAL/SQL), so skill extraction for SQL will overcount here.
- Job 269 (Yash Technologies): headline "Business Analyst - Business Analysis Job", work is indirect tax (US sales/use tax, VAT) and Vertex configuration, 4 to 6 years; different job family, exclude candidate. Non-breaking hyphens in the text.
- Job 270 (Regnology Group): "Junior Business Analyst- Regulatory Reporting" (no space before the hyphen), portal and description both 2 to 5 years; entry-level title with an experience requirement (Question 4). Regulatory reporting, UAT and SQL; borderline. Typo "Charted Accountants"; ends with a blank line.
- Job 271 (Alphasense): "Sales Operations Analyst", description calls it "Sales Operations Reporting Analyst"; Salesforce reports and dashboards, CRM data quality; portal Fresher, no years stated; borderline for Question 5. Foundit title-cased the fraud-warning heading.
- Job 272 (BAJAJ FINSERV HEALTH): "MIS Executive (Data management, PwD)", open only to persons with disabilities (UDID certificate mandatory); mixes MIS with IT system administration, cash handling and customer-facing duties; portal 0-3 and description "up to 3 years", "Freshers are eligible" next to "must have experience leading MIS-related projects". The description ends with a Foundit summary line ("Work from office · 6 days a week · Also in: Bangalore, Hyderabad, Kolkata, Lucknow, Delhi"). Borderline; add an eligibility-restricted flag in Phase 3.
- Job 273 (Maxgen Technologies): "DATA ANALYST INTERNSHIP AT PUNE", city field "Pune, Aurangabad, Dhule" (multi-city); a training institute advertising an internship and data analytics program with "job placement in top MNC"; not an employer posting; exclude candidate. Salary "₹ 2.5 - 5 LPA" is likely a placement claim.
- Experience in this block (description): 273 (freshers) is entry-level; 272 says up to 3 and "freshers eligible"; 271 states no years against portal Fresher; 270 asks 2 to 5; 269 asks 4 to 6; 265 asks 5 to 7; 267 says 6+ and 5 to 8; 268 asks 7 to 10; 266 asks 8+.
- Duplicate check on all Foundit rows (job ID at the end of the URL): 0 duplicate pairs among 29 rows. No cross-portal matches spotted by eye; detection is in Pandas.

### Foundit, Chennai block (jobs 274 to 283)

- Foundit Chennai block done, 10 rows (planned 10). Title mix by actual title: Data Analyst 4 (274 to 277, 275 is "Senior Data Analyst"), Business Analyst 3 (278 to 280), Operations 2 (281, 282), Associate 1 (283), MIS 0, Intern 0. Entry-level by title: 1 row against 2 planned; no Junior, Fresher or Intern titles were found in Chennai.
- Foundit salary is Not disclosed on all 10 rows (1 of 39 Foundit rows so far).
- industry_type: job 282 shows "Banking/Accounting/Financial Services". Values seen so far: Other, Consulting/Advisory Services, Information Technology, Banking/Accounting/Financial Services.
- Job 274 (U.S. Bank): duties read junior (supports senior analysts, foundational SQL, introductory Python or R) but portal and description ask 5+ years.
- Job 275 (Tegna): ad tech DSP analytics, 6+ years in the preferred section; text from other roles is mixed in ("CloudEngineer" in the overview, "As a DevOps Engineer" in the closing); words glued ("costper").
- Job 276 (husky technologies): title includes the company and location; IIoT cloud analytics (Azure, Kusto, ML), 5+ years "design experience"; "TM" glued to the company name; typo "Sold understanding".
- Job 277 (cortixiq gi): "Data Analyst - Quantitative", portal Fresher but the description asks for "proven experience in Data Analytics" with no years; fully remote, so Chennai is the search location; section headings run inline ("Company Description CortixIQ...").
- Job 278 (luxoft india): "Senior Business Analyst- Credit Risk (4-7 yrs)- Chennai", credit risk, BCBS 239 and Basel regulatory work, 4 to 7 years; the Experience, Location, Work Mode and Skills lines appear twice; borderline (domain-heavy, SQL one skill among many).
- Job 279 (papigen): "Senior Business Analyst", equity portfolio systems requirements work (BRDs, user stories, BPMN), 8+ years, SQL as one bullet; ends with an appended "Skills:" line; borderline.
- Job 280 (Amazon Robotics): company label differs from the description (Amazon Retail Business Services; company line "ADCI - Tamil Nadu - A83"); title includes the team names; dashboards and SQL for a work-authorization program; asks 3+ years and 5+ years of Excel.
- Job 281 (AstraZeneca): "Analyst-Campaign Operations Analyst, Salesforce MCA and Adobe Campaign", builds email and journey campaigns in Salesforce Marketing Cloud and Adobe Campaign, 4 to 6 years; marketing campaign execution, not data analysis; off-target, exclude candidate. Description includes an internal recruiter note about "alternative messaging" and the dates "Date Posted 06-Nov-2026" and "Closing Date 12-Nov-2026" (day-month-year), next to Foundit's "Posted 2 days ago".
- Job 282 (Bank of America): "Regulatory Reporting Operations Analyst", RBI regulatory report preparation and reconciliation in Excel; portal Fresher but the role summary says "experienced professional"; bullets start with ". "; "Job Description:" appears twice; borderline for Question 5 (regulatory reporting, near compliance).
- Job 283 (UPS): "Associate Data Analyst" with a skill list in the title ("C , .NET": a character such as # was probably dropped), description calls the role "Visualization Expert", minimum 2 years; entry-level title with an experience requirement (Question 4); description starts with a language-preference notice; posted a month ago.
- Experience in this block (description): no clean fresher row; 277 and 282 say Fresher on the portal but the descriptions ask for experience; 283 asks 2+; 281 asks 4 to 6; 278 asks 4 to 7; 274 and 276 ask 5+; 275 asks 6+; 279 asks 8+; 280 asks 3+ (and 5+ years of Excel).
- Foundit Operations rows so far (253, 262, 271, 281, 282) are all non-classic: off-target, sales operations or regulatory reporting.
- No MIS Executive row was collected in Chennai.
- Duplicate check on all Foundit rows (job ID at the end of the URL): 0 duplicate pairs among 39 rows. No cross-portal matches spotted by eye; detection is in Pandas.

### Foundit, Mumbai block (jobs 284 to 293)

- Foundit Mumbai block done, 10 rows (planned 10), all with city Mumbai. Title mix by actual title: Data Analyst 4 (284 to 287; 286 "Data Analyst-I" also counts as entry-level by the level marker), Business Analyst 3 (288 to 290), Operations 1 (291), MIS 1 (292), Associate 1 (293). Entry-level by title: 2 (286, 293).
- Foundit salary is Not disclosed on all 10 rows (1 of 49 Foundit rows so far).
- industry_type: job 287 shows "Insurance", job 292 shows "Banking/Accounting/Financial Services", job 293 shows Not mentioned (no industry on the page).
- Job 284 (The Sleep Company): clean D2C Data Analyst row, 3 to 5 years, SQL with joins, CTEs and window functions.
- Job 285 (FedEx): headline "Senior Data Analyst (Revenue Analytics)", description title "Senior Analyst – Pricing and Marketing Analytics"; pricing analytics with predictive models; 6 to 10 years in the portal, "6–8+ years" in the description.
- Job 286 (etraveli group): "Data Analyst-I" (no space before the hyphen), portal and description both 3 to 5 years; entry-level title by the "I" marker with an experience requirement (Question 4). Customer Services KPI reporting with Qlik Sense.
- Job 287 (Marsh): headline "Senior Data Analyst - Python", description title "Senior Principal Engineer - Digital Visualization & Data Analytics Development"; portal 6-8 years, description "6- 7 years"; insurance or finance domain; posted 2 months ago.
- Job 288 (Bnp Paribas Bank): "Assistant Manager Business Analyst Calypso IT", back-office settlement of bonds and repos, Level 3 support, UAT, 7+ years, SQL at intermediate level; no data analysis, borderline. The closing paragraph repeats.
- Job 289 (Priceline): product Business Analyst, SQL, Hadoop and Tableau, 3 to 5 years; the description requires a Master's degree in Mathematics or Statistics (education gate); long benefits boilerplate.
- Job 290 (Mcaffeine): Business Analyst for a D2C brand (company overview says PEP), 2 to 5 years; the degree must be from a "Tier 1 Institute" (education gate).
- Job 291 (MediaNet): "Operations Analyst", ad tech reporting with Excel (VLOOKUP, pivot tables) and PowerPoint, portal Fresher, no years stated; first Foundit Operations row that is mostly data reporting. Names the founder; the text is double-spaced; company shown as "MediaNet", description says "Media.net". Check against LinkedIn job 166 (Media.net) in Pandas.
- Job 292 (Kotak Securities): title has code fields ("MIS Executive_HOUSING FINANCE_0773_1459_1041182"); portal Fresher but the description asks for 3+ years and mandatory financial services experience; encoding glitch ("â€"); sentences run together; "AVS" listed as a skill without explanation.
- Job 293 (Havas group): "Associate Data Analyst - CSA", agency PivotRoots, performance marketing analytics, portal Fresher, description "0-2 years... experienced candidates preferred"; the equal-opportunity paragraph appears twice. Probable third copy of Naukri job 82 and LinkedIn job 170 (confirm in Pandas).
- Experience in this block (description): 291 (no years) and 293 (0 to 2) are entry-level; 292 asks 3+ against portal Fresher; 290 asks 2 to 5; 284, 286, 289 ask 3 to 5; 285 asks 6 to 8+; 287 asks 6 to 7; 288 asks 7+.
- Duplicate check on all Foundit rows (job ID at the end of the URL): 0 duplicate pairs among 49 rows.

### Foundit, Delhi/NCR block (jobs 294 to 303)

- Foundit Delhi/NCR block done, 10 rows (planned 10); Foundit closes at 59 rows (target 60). City mix: Delhi 8 (294 to 300, 302), Gurugram 2 (301, 303), Noida 0. Title mix by actual title: Data Analyst 4 (294 to 297; 294 is "Senior Data Analyst"), Business Analyst 2 (298, 299), MIS 1 (300), Associate 2 (301, 303), other 1 (302, "Data operations"). Entry-level by title: 2 (301, 303). No classic Operations Analyst row (299 is Revenue Operations).
- Foundit salary is Not disclosed on all 10 rows (1 of 59 Foundit rows so far).
- industry_type: job 298 "IT/Computers - Software", job 302 "Other Roles", job 303 "Banking/Accounting/Financial Services", the rest "Other". Values seen so far: Other, Other Roles, Consulting/Advisory Services, Information Technology, Banking/Accounting/Financial Services, Insurance, IT/Computers - Software.
- Job 294 (Atlys): "Senior Data Analyst", 3 to 6 years in portal and description; SQL, Power BI, Tableau, Looker Studio, Metabase; on-target, clean.
- Job 295 (Revolut): headline "Data Analyst (Engineer)", description says "Senior Data Analyst", 7+ years, manages a team; portal 7-9 years; garbled sentence ("Up to shape what's next in finance Let's get in touch."); long company boilerplate.
- Job 296 (9ap batteries - ambit transmission products pvt. ltd.): title "Data Analyst_." (trailing "_."), description title "Data Analyst -||- MIS"; fully remote, so Delhi is the search location; portal and description say 3 to 6 years but the text also says "ideal for fresh graduates" and "internships or academic projects accepted"; company name in lowercase and very long.
- Job 297 (fin lad investments): "Data Analyst", portal Fresher, no years in the description; first Foundit Data Analyst row that is Fresher in the portal with no experience asked; SQL, Python or R only "preferred"; posted 2 months ago, over 500 applicants; company in lowercase.
- Job 298 (NTT Data): "Salesforce Business Analyst", portal Fresher but the description asks 8 to 10 years, UK time zone, SVP-level work; Salesforce "nice to have"; skills_portal lists Excel function names (XLOOKUP, VSTACK, FILTER, GROUPBY) as tags, which collide with common words in skill extraction; contact details removed by Foundit leave broken sentences ("please submit a contact us form, ."); the description lists email domains (replace with [removed]); borderline.
- Job 299 (Pentair): "Business Analyst - Revenue Operations", 2 to 5 years, ETL, Power BI, SQL, Python, reporting for sales leadership; same kind as jobs 213 and 223; decide in Phase 3 whether it counts in the Operations group for Question 5.
- Job 300 (evarastaffing): "SENIOR MIS EXECUTIVE" (capitals) with portal Fresher, no years in the description; recruiter ad with the employer unnamed; SQL listed as "Preferred" while the tags list Sql; ends with an appended "Skills:" line; company in lowercase.
- Job 301 (Gartner): "Associate Data Analyst", Gurugram, portal 0 - 2 years, description "0-1 years"; hybrid (work_mode_portal is Not mentioned); description contains a phone number (replace with [removed]) and Foundit's "[Confidential Information]" mask; long company, AI and EEO boilerplate.
- Job 302 (Freelancer Rajender Narang): "Data operations ( 4 guys needed)", an individual freelancer's posting, not an employer; portal Fresher; generic data-management template; 10 stuffed skill tags (Cloud Computing, Api Integration, Statistical Analysis); industry "Other Roles"; city "Delhi, Delhi NCR"; borderline, decide in Phase 3.
- Job 303 (Fidelity International): "Associate Data Analyst", portal Fresher, description asks "2-5 years prior experience in a data management role"; "Application Deadline: 08 November 2026" had already passed on the collection date while Foundit shows "Posted 5 days ago"; the closing paragraph appears twice; entry-level title with an experience requirement (Question 4). Probable cross-portal duplicate of LinkedIn job 176.
- Experience in this block (description): 297, 300 (portal Fresher) and 302 state no years or ask for freshers; 301 asks 0 to 1; 299 asks 2 to 5; 303 asks 2 to 5 against portal Fresher; 294 and 296 ask 3 to 6; 295 asks 7+; 298 asks 8 to 10 against portal Fresher.
- Duplicate check on all Foundit rows (job ID at the end of the URL): 0 duplicate pairs among 59 rows.

### Known reposts and cross-portal duplicates (for Phase 3 dedupe)

- Reposts within Naukri: jobs 1 and 4 (pilot), 30 and 33 (MitKat), 59 and 72 (LeadWinner), 64 and 86 (Securens)
- Reposts within LinkedIn: jobs 118 and 159 (Portcast), 145 and 155 (Citi)
- Cross-portal: Naukri job 77 and LinkedIn job 141 (Zema Global); Naukri job 82 and LinkedIn job 170 (Havas Media / PivotRoots)
- Job 79 (MitKat) was checked against 30 and 33 and is not a repost.
- Add Indeed and Foundit matches after those blocks close. Detection is done in Pandas (company, title, description), not in Excel.
- Indeed Bengaluru block (jobs 185 to 196): no reposts or cross-portal matches spotted by eye; real detection is done in Pandas (company, title, description).
- Indeed Pune block (jobs 207 to 216): none spotted by eye. Job 208 is a staffing-agency posting and may reappear under another company name; real detection is in Pandas.
- Reposts within Indeed: jobs 211 and 238 (AlphaSense Business Analyst II, Pune and Delhi).
- Cross-portal: Indeed job 205 and Foundit job 263 (TriNet, Associate Data Analyst, Hyderabad). Probable: LinkedIn job 123 and Foundit job 259 (vidaXL, Data Analyst, Hyderabad); confirm in Pandas.
- Probable cross-portal: Naukri job 82, LinkedIn job 170 and Foundit job 293 (Havas / PivotRoots, Associate Data Analyst, Mumbai; same "0-2 years... experienced candidates preferred" text and equal-opportunity paragraph twice); confirm in Pandas. Check whether LinkedIn job 166 and Foundit job 291 (Media.net) are the same posting.
- Probable cross-portal: LinkedIn job 176 and Foundit job 303 (Fidelity International, Associate Data Analyst, Gurugram); confirm in Pandas.

### Limitations (for the Phase 6 write-up)

- Naukri sort order varied across blocks (Date or a mix in Bangalore and Hyderabad, Relevance from Pune onward), so sampling is not strictly uniform.
- City quotas are unequal: Naukri Bangalore has 24 rows (20 plus 4 second pass) against 14 in most other cities, and Pune has 15. LinkedIn blocks range from 11 to 15 rows.
- Relevance sort returns many old postings (some from 2023 to 2025 by URL ID date), so "current openings" may be overstated; filter on URL date in Phase 3.
- Chennai has few Data Analyst, MIS and Operations postings on Naukri, so its block is mostly Business Analyst.
- Collection used a fixed quota per city, so the sample cannot show which city has the most openings. Question 2 was reworded in questions.md to share of fresher or entry-level roles and title mix per city, not city size.
- Excel duplicate highlighting on the description column did not flag known identical pairs (jobs 1/4, 30/33, 59/72), so repost detection is done in Pandas in Phase 3, not in Excel.
- LinkedIn Date posted filter was not used (too few postings with it). Many LinkedIn rows are 2 months old or older (for example jobs 111, 118, 133, 147, 168, 181, 182), so "current openings" may be overstated; count them with posted_ago in Phase 3.
- Filter deviations on LinkedIn: the Experience level filter was used for the entry-level retry in the Bengaluru block, and a salary filter was active in the search that returned job 141 (f_SAL in the URL). Both break the no-filter rule and may bias those rows.
- Cross-portal duplicates exist (Naukri job 77 and LinkedIn job 141; Naukri job 82 and LinkedIn job 170); URL-ID checks only catch duplicates within a portal, so dedupe across portals by company, title and city in Phase 3.
- LinkedIn rows skew toward large multinationals and financial-services captive centers (Mastercard, JPMorgan, BlackRock, Citi, Deutsche Bank, Experian and others), unlike Naukri, which has more small and mid-size firms. Entry-level postings on LinkedIn are rare and often carry "Associate" titles that ask for 3 to 5+ years.
- Operations Analyst and MIS postings are thin on all four portals, which weakens Question 5.
- Indeed rows come from keyword searches (fresher, intern, mis executive, data analyst) with the default 25 km radius, so the title groups are keyword-driven and the radius can include nearby towns.
- Indeed shows salary on very few postings and has no experience or skill fields, so Indeed adds little to Question 3 and relies on description extraction for everything else.
- Indeed has no posting date, so old postings cannot be removed from Indeed rows.
- Indeed Business Analyst rows are 12 of 60 non-pilot rows and mostly software requirements, reconciliation or MIS-type work (jobs 189, 198, 202, 220, 229, 239); data-heavy Business Analyst postings are rare. Bengaluru and Hyderabad rows (188, 189, 198, 201, 202) came from keyword searches for other titles, not a "business analyst" search, and Mumbai returned only one, so Question 5 may under-sample Business Analyst postings on Indeed.
- Indeed Pune Data Analyst rows were taken from result pages 2 to 8 (start=10 to 70), so they are not the top-ranked results.
- Indeed Pune shows salary on 6 of 10 rows, more than Bengaluru or Hyderabad, but 2 of those are internship stipends and 1 is a 25+ LPA contract role (outlier).
- Pimpri-Chinchwad postings (210, 214) are counted as Pune-area rows; the primary city rule is set in Phase 3.
- Indeed MIS Executive rows are over-represented against the plan (10 of 60 non-pilot rows: jobs 193, 194, 195, 204, 214, 222, 225, 230, 231, 241), so Question 5 compares more MIS rows than Operations rows on Indeed.
- The Indeed "operations analyst" search mostly returns Revenue Operations or Product Operations roles, so the Operations group on Indeed is not classic operations analyst work.
- No on-target Operations Analyst postings were found on Indeed in Hyderabad, Mumbai or Delhi/NCR, and the ones found elsewhere are Revenue or Product Operations roles (jobs 192, 213, 223).
- Indeed Delhi/NCR rows come from three separate location searches (Delhi, Noida, Gurugram), typed inconsistently, and two URLs have no radius setting.
- Foundit Operations Analyst and MIS Executive postings are thin: no on-target MIS Executive postings were found on Foundit in Hyderabad and Chennai.
- Foundit has almost no salary data (1 of 59 rows, and that one is a training-institute internship ad) and skews senior: 22 of 24 Data Analyst-titled Foundit rows have a portal minimum of 2 years or more; the exceptions (jobs 277 and 297) say Fresher in the portal, and job 277 asks for proven experience in the description. Foundit's Operations group is mostly not classic operations analyst work (jobs 253, 262, 271, 281, 282); job 291 is the exception.
- The Fresher label is unreliable: Foundit jobs 251, 261, 277, 282 and 292 say Fresher in the portal but ask for experience in the description; Indeed job 242 is labelled Fresher but asks for senior skills (Power BI development, team lead); Foundit jobs 298 and 303 say Fresher in the portal but ask for 8 to 10 and 2 to 5 years.
- Search terms and result pages were not recorded for the Foundit blocks; title groups were sampled by searching each title, so they compare skills, not market share.
