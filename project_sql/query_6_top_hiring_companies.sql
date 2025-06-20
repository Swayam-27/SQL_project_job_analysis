/*
Which companies are hiring the most Data Scientists and how much do they pay?
- Filter only for job_title = 'Data Scientist' with non-null salary info
- Group by job_title_short and company name
- Count the number of job postings and average the salaries
- Why? This gives insight into which companies are investing most heavily in data science talent, and what they are willing to pay.

*/

SELECT
    job_postings_fact.job_title_short,
    ROUND(AVG(salary_year_avg),0) as avg_salary,
    name AS company_name,
    COUNT(*) AS num_jobs
FROM 
    job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id=job_postings_fact.company_id
WHERE 
    job_title='Data Scientist' AND salary_year_avg IS NOT NULL
GROUP BY 
    job_title_short, company_name
ORDER BY 
    num_jobs DESC;

/*
Here's what we find:
- Major hiring companies include **Selby Jennings**, **Algo Capital Group**, and **Storm4**, each posting multiple DS roles.
- Average salaries range between **$260k - $550k**, depending on the company.
- This analysis is helpful for candidates targeting companies with a strong data science presence.
*/