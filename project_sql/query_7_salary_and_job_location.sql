/*
How does job location impact the average salary for Data Scientists?
- Filter by job_title = 'Data Scientist' and exclude null salaries
- Group by job_location
- Count jobs and compute average salary per location
- Why? It helps identify high-paying cities or states for Data Scientists, which can guide job seekers in relocating or negotiating salaries.

*/

SELECT 
    job_location, 
    COUNT(*) AS num_jobs,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
WHERE job_title='Data Scientist' AND salary_year_avg IS NOT NULL
GROUP BY job_location, job_title_short
ORDER BY avg_salary DESC;

/*
Key Insights:
- Certain remote or metro locations (e.g., **"Anywhere"**, **California**, **New York**) tend to offer higher average salaries.
- High cost-of-living areas often coincide with higher pay, which is relevant for job seekers evaluating compensation fairness.
- Some unexpected states or cities may offer top-tier salaries, showing opportunities beyond traditional tech hubs.
*/