# Method notes

## Status

- Naukri closed at 99 rows (including 4 pilot rows), target 100.
- LinkedIn closed at 80 rows (including 4 pilot rows), target 80.
- Indeed in progress: Bengaluru (jobs 185 to 196, 12 rows), Hyderabad (jobs 197 to 206, 10 rows) and Pune (jobs 207 to 216, 10 rows) done; 34 Indeed rows with the 2 pilot rows, target 60. Next: Indeed Chennai from job 217, then Mumbai and Delhi/NCR, then Foundit (target 60).
- Update this section each time a portal closes.

## Collection rules

- Portal fields fill the structured columns exactly as shown; copy portal wording exactly
- Experience, skills and education are extracted from description text in Phase 3, same rules for all sources
- Missing values use: Not mentioned / Not disclosed / No tags / Confidential. Never blank, never NA or 0
- Phone numbers and emails in descriptions are replaced with [removed]; the rest of the text is unchanged
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

### Known reposts and cross-portal duplicates (for Phase 3 dedupe)

- Reposts within Naukri: jobs 1 and 4 (pilot), 30 and 33 (MitKat), 59 and 72 (LeadWinner), 64 and 86 (Securens)
- Reposts within LinkedIn: jobs 118 and 159 (Portcast), 145 and 155 (Citi)
- Cross-portal: Naukri job 77 and LinkedIn job 141 (Zema Global); Naukri job 82 and LinkedIn job 170 (Havas Media / PivotRoots)
- Job 79 (MitKat) was checked against 30 and 33 and is not a repost.
- Add Indeed and Foundit matches after those blocks close. Detection is done in Pandas (company, title, description), not in Excel.
- Indeed Bengaluru block (jobs 185 to 196): no reposts or cross-portal matches spotted by eye; real detection is done in Pandas (company, title, description).
- Indeed Pune block (jobs 207 to 216): none spotted by eye. Job 208 is a staffing-agency posting and may reappear under another company name; real detection is in Pandas.

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
- Operations Analyst and MIS postings are thin on both portals, which weakens Question 5.
- Indeed rows come from keyword searches (fresher, intern, mis executive, data analyst) with the default 25 km radius, so the title groups are keyword-driven and the radius can include nearby towns.
- Indeed shows salary on very few postings and has no experience or skill fields, so Indeed adds little to Question 3 and relies on description extraction for everything else.
- Indeed has no posting date, so old postings cannot be removed from Indeed rows.
- Indeed Business Analyst rows from Bengaluru and Hyderabad (jobs 188, 189, 198, 201, 202) came from "data analyst" or "fresher" keyword searches, not from a "business analyst" search, so Question 5 may under-sample Business Analyst postings on Indeed.
- Most Business Analyst postings found on Indeed so far are software requirements or reconciliation roles with little data work.
- Indeed Pune Data Analyst rows were taken from result pages 2 to 8 (start=10 to 70), so they are not the top-ranked results.
- Indeed Pune shows salary on 6 of 10 rows, more than Bengaluru or Hyderabad, but 2 of those are internship stipends and 1 is a 25+ LPA contract role (outlier).
- Pimpri-Chinchwad postings (210, 214) are counted as Pune-area rows; the primary city rule is set in Phase 3.
