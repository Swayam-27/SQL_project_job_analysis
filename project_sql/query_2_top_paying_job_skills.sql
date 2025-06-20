/*
What skills are required for the top-paying data scientists jobs?
- Use the top 10 highest-paying Data Scientist jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        job_posted_date::DATE,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Scientist' 
        AND job_location = 'Anywhere' 
        AND salary_year_avg IS NOT NULL 
    ORDER BY 
        salary_year_avg DESC
    LIMIT 20
)
SELECT 
    top_paying_jobs.*, 
    skills_dim.skills,
    skills_dim.type
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim 
    ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim 
    ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC;

/*
Here's the breakdown of the most demanded skills for data scientists in 2023, based on job postings:
Python is leading with a bold count of 11.
SQL follows with a bold count of 9.
Spark, Tableau, and TensorFlow are also highly sought after, each with a bold count of 6.
Other important skills include PyTorch, AWS, Java, and Hadoop, showing significant demand in the market.
Niche but notable mentions include Scikit-learn, R, Qlik, BigQuery, Kubernetes, Cassandra, Airflow, and Looker—indicating the variety of tech stacks companies use.

-- [
--   {"job_id": 40145, "job_title": "Staff Data Scientist/Quant Researcher", "salary_year_avg": "550000.0", "job_posted_date": "2023-08-16", "company_name": "Selby Jennings", "skills": "sql", "type": "programming"},
--   {"job_id": 40145, "job_title": "Staff Data Scientist/Quant Researcher", "salary_year_avg": "550000.0", "job_posted_date": "2023-08-16", "company_name": "Selby Jennings", "skills": "python", "type": "programming"},
--   {"job_id": 1714768, "job_title": "Staff Data Scientist - Business Analytics", "salary_year_avg": "525000.0", "job_posted_date": "2023-09-01", "company_name": "Selby Jennings", "skills": "sql", "type": "programming"},
--   {"job_id": 1131472, "job_title": "Data Scientist", "salary_year_avg": "375000.0", "job_posted_date": "2023-07-31", "company_name": "Algo Capital Group", "skills": "sql", "type": "programming"},
--   {"job_id": 1131472, "job_title": "Data Scientist", "salary_year_avg": "375000.0", "job_posted_date": "2023-07-31", "company_name": "Algo Capital Group", "skills": "python", "type": "programming"},
--   {"job_id": 1131472, "job_title": "Data Scientist", "salary_year_avg": "375000.0", "job_posted_date": "2023-07-31", "company_name": "Algo Capital Group", "skills": "java", "type": "programming"},
--   {"job_id": 1131472, "job_title": "Data Scientist", "salary_year_avg": "375000.0", "job_posted_date": "2023-07-31", "company_name": "Algo Capital Group", "skills": "cassandra", "type": "databases"},
--   {"job_id": 1131472, "job_title": "Data Scientist", "salary_year_avg": "375000.0", "job_posted_date": "2023-07-31", "company_name": "Algo Capital Group", "skills": "spark", "type": "libraries"},
--   {"job_id": 1131472, "job_title": "Data Scientist", "salary_year_avg": "375000.0", "job_posted_date": "2023-07-31", "company_name": "Algo Capital Group", "skills": "hadoop", "type": "libraries"},
--   {"job_id": 1131472, "job_title": "Data Scientist", "salary_year_avg": "375000.0", "job_posted_date": "2023-07-31", "company_name": "Algo Capital Group", "skills": "tableau", "type": "analyst_tools"}
{"job_id": 126218, "job_title": "Director Level - Product Management - Data Science", "salary_year_avg": "320000.0", "job_posted_date": "2023-03-26", "company_name": "Teramind", "skills": "azure", "type": "cloud"},
--   {"job_id": 126218, "job_title": "Director Level - Product Management - Data Science", "salary_year_avg": "320000.0", "job_posted_date": "2023-03-26", "company_name": "Teramind", "skills": "aws", "type": "cloud"},
--   {"job_id": 126218, "job_title": "Director Level - Product Management - Data Science", "salary_year_avg": "320000.0", "job_posted_date": "2023-03-26", "company_name": "Teramind", "skills": "tensorflow", "type": "libraries"},
--   {"job_id": 126218, "job_title": "Director Level - Product Management - Data Science", "salary_year_avg": "320000.0", "job_posted_date": "2023-03-26", "company_name": "Teramind", "skills": "keras", "type": "libraries"},
--   {"job_id": 126218, "job_title": "Director Level - Product Management - Data Science", "salary_year_avg": "320000.0", "job_posted_date": "2023-03-26", "company_name": "Teramind", "skills": "pytorch", "type": "libraries"},
--   {"job_id": 126218, "job_title": "Director Level - Product Management - Data Science", "salary_year_avg": "320000.0", "job_posted_date": "2023-03-26", "company_name": "Teramind", "skills": "scikit-learn", "type": "libraries"},
--   {"job_id": 126218, "job_title": "Director Level - Product Management - Data Science", "salary_year_avg": "320000.0", "job_posted_date": "2023-03-26", "company_name": "Teramind", "skills": "datarobot", "type": "analyst_tools"},
--   {"job_id": 226011, "job_title": "Distinguished Data Scientist", "salary_year_avg": "300000.0", "job_posted_date": "2023-08-06", "company_name": "Walmart", "skills": "scala", "type": "programming"},
--   {"job_id": 226011, "job_title": "Distinguished Data Scientist", "salary_year_avg": "300000.0", "job_posted_date": "2023-08-06", "company_name": "Walmart", "skills": "java", "type": "programming"}
-- ]

*/
