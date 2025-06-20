/*
What are the top-paying data scintist jobs?
- Identify the top 20 highest-paying Data Scientist roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Scientists, offering insights into employment options and location flexibility.
*/

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE,
    job_via,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short='Data Scientist' AND job_location='Anywhere' AND salary_year_avg IS NOT NULL 
ORDER BY 
    salary_year_avg DESC
LIMIT 20;

/*
Here's the breakdown of the top data scientist jobs in 2023:

High-End Compensation:
The top 20 roles range from **$262,500** to **$550,000**, showcasing lucrative opportunities across leadership, research, and advanced data science domains.

Broad Employer Base:
Companies span finance (Selby Jennings), tech (Reddit, Walmart), consulting (Storm4, Teramind), and retail (Home Depot), proving cross-industry demand.

Fully Remote-Friendly:
Every role is listed as “Anywhere,” reinforcing how data science continues to lead in remote work flexibility for top-tier talent.

RESULTS
=======
[
  {
    "job_id": 40145,
    "job_title": "Staff Data Scientist/Quant Researcher",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "550000.0",
    "job_posted_date": "2023-08-16",
    "company_name": "Selby Jennings"
  },
  {
    "job_id": 1714768,
    "job_title": "Staff Data Scientist - Business Analytics",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "525000.0",
    "job_posted_date": "2023-09-01",
    "company_name": "Selby Jennings"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "375000.0",
    "job_posted_date": "2023-07-31",
    "company_name": "Algo Capital Group"
  },
  {
    "job_id": 1742633,
    "job_title": "Head of Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "351500.0",
    "job_posted_date": "2023-07-12",
    "company_name": "Demandbase"
  },
  {
    "job_id": 551497,
    "job_title": "Head of Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "324000.0",
    "job_posted_date": "2023-05-26",
    "company_name": "Demandbase"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "320000.0",
    "job_posted_date": "2023-03-26",
    "company_name": "Teramind"
  },
  {
    "job_id": 1161630,
    "job_title": "Director of Data Science & Analytics",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "313000.0",
    "job_posted_date": "2023-08-23",
    "company_name": "Reddit"
  },
  {
    "job_id": 226011,
    "job_title": "Distinguished Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "300000.0",
    "job_posted_date": "2023-08-06",
    "company_name": "Walmart"
  },
  {
    "job_id": 129924,
    "job_title": "Director of Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "300000.0",
    "job_posted_date": "2023-01-21",
    "company_name": "Storm4"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "300000.0",
    "job_posted_date": "2023-11-24",
    "company_name": "Storm5"
  },
  {
    "job_id": 457991,
    "job_title": "Head of Battery Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "300000.0",
    "job_posted_date": "2023-10-02",
    "company_name": "Lawrence Harvey"
  },
  {
    "job_id": 178888,
    "job_title": "Pre-Sales Data Scientist, Financial Services",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "288000.0",
    "job_posted_date": "2023-08-26",
    "company_name": "Teradata"
  },
  {
    "job_id": 1177572,
    "job_title": "Data Science Manager, Online Customer Experience Intelligence (Remote)",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "280000.0",
    "job_posted_date": "2023-04-13",
    "company_name": "Home Depot / THD"
  },
  {
    "job_id": 886101,
    "job_title": "Distinguished Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "275000.0",
    "job_posted_date": "2023-06-27",
    "company_name": "Torc Robotics"
  },
  {
    "job_id": 158782,
    "job_title": "Data Scientist",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "275000.0",
    "job_posted_date": "2023-07-04",
    "company_name": "Algo Capital Group"
  },
  {
    "job_id": 89798,
    "job_title": "Director, Data Science",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "265000.0",
    "job_posted_date": "2023-07-26",
    "company_name": "Cnam - Auditeurs - Accueil"
  },
  {
    "job_id": 1325996,
    "job_title": "Chief Data Officer",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "265000.0",
    "job_posted_date": "2023-07-27",
    "company_name": "ZealoTech People"
  },
  {
    "job_id": 257651,
    "job_title": "Data Science Vice President",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "265000.0",
    "job_posted_date": "2023-01-27",
    "company_name": "Storm6"
  },
  {
    "job_id": 100410,
    "job_title": "Director of Data Science & AI Rese_
