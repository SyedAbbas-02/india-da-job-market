# Method notes

## Collection rules

- Portal fields fill the structured columns exactly as shown
- Experience, skills and education are extracted from description text in Phase 3, same rules for all sources
- Missing values use: Not mentioned / Not disclosed / No tags / Confidential

## Things noticed (add one line each time)

- Jobs 1 and 4 look like reposts of the same posting (same company, cities, description opening; salary and tags differ)
- Job 2: description text lost a dash in the experience line, so portal header value was used
- LinkedIn has no skill tags or experience field; Naukri does
- Pilot (n=10: 4 Naukri, 4 LinkedIn, 2 Indeed) took about 1.5 hours; later postings take less
- Portal header fields differ: Naukri shows salary, experience and skill tags; LinkedIn and Indeed mostly do not (salary shown for 5 of 10 pilot postings, all Naukri except one Indeed)
- Target revised from 400 to 300 postings (stretch 400) because of collection time
- Experience, skills and education are extracted from description text for all sources
- Job 10 (Indeed): "Data Analyst Trainer" is a teaching role that matches the search term but not the job type; decide in Phase 3 whether to exclude
- Portal columns renamed with a _portal suffix (experience_portal, skills_portal, salary_portal, work_mode_portal) because extracted values from description text become separate columns in Phase 3
