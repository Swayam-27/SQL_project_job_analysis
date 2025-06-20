# Introduction

📊 Dive into the data science job market! This project focuses on Data Scientist roles, analyzing top-paying positions, in-demand skills, and the intersection of high demand and high salary in the data science field.

🔍 Check out all SQL queries here: [project_sql folder](/project_sql/)

# Background

This project is part of my personal SQL learning journey, inspired by Luke Barousse's SQL Course. My goal was to go beyond basic queries and uncover meaningful insights about the data science job landscape. By digging into job postings, I aimed to find which roles pay the most, what skills are truly valuable, and how to position myself (or help others) for maximum career impact.

### Questions explored:

1. What are the top-paying Data Scientist jobs?
2. What skills do those top-paying jobs require?
3. What skills are most in demand for Data Scientists?
4. Which skills are associated with higher average salaries?
5. What are the most optimal skills to learn based on both salary and demand?
6. Which companies hire the most Data Scientists?
7. Is there any correlation between job location and average salary?

# Tools I Used

- **SQL** for querying and analysis
- **PostgreSQL** as the database engine
- **Visual Studio Code** as the IDE
- **Git & GitHub** for version control and collaboration

# The Analysis

### 1. Top Paying Data Scientist Jobs

A query filtered for Data Scientist roles with remote ("Anywhere") availability and sorted them by descending average salary.

```sql
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
```

![Top Paying Data Science Jobs](/assets/query_1.png)

**Here's the breakdown of the top data scientist jobs in 2023:**

- Wide Salary Range: The top 20 highest-paying remote Data Scientist roles span from $265,000 to over $550,000, highlighting the massive compensation potential for advanced skill sets in data science.

- Diverse Employers: Companies such as Selby Jennings (finance), Walmart (retail/tech), and Algo Capital Group (crypto/AI) dominate the list, reflecting cross-industry demand.

- Remote-First Advantage: Every job listed is remote, signaling a permanent shift toward high-paying, location-agnostic tech hiring.

- Seniority & Specialization: Titles often imply senior or niche focus (e.g., "Machine Learning Lead", "Quantitative Researcher"), suggesting that domain expertise directly drives salary growth.

### 2. Skills Required for Top-Paying Jobs

Using the job IDs from the top 20 paying jobs, we join them with skills data to see the most commonly required tools.

```sql
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
```

**Here's the breakdown of the most demanded skills for the top 20 highest paying jobs:**

- Python Dominance: Found in over 50% of top-paying roles, Python remains the backbone of data pipelines, modeling, and automation.

- SQL as a Constant: Appears in 9 of 20 roles, reinforcing its foundational role in data access—even at high compensation levels.

- Emerging Tech Stack: Tools like Spark, TensorFlow, and Tableau appear consistently, indicating a hybrid demand for big data, deep learning, and visualization.

- AI & Cloud Friendly: The presence of tools like AWS, Airflow, and Kubernetes (in some roles) underscores the move toward scalable, cloud-based data science environments.

### 3. Most In-Demand Skills

This query counts the number of job postings that require each skill.

```sql
WITH top_skills AS (
    SELECT 
        skill_id,
        COUNT(*) AS demand
    FROM 
        skills_job_dim as skill_to_job
    INNER JOIN 
        job_postings_fact ON job_postings_fact.job_id = skill_to_job.job_id
    WHERE job_postings_fact.job_title_short='Data Scientist'
    GROUP BY 
        skill_id
)
SELECT 
    skills AS skill_name,
    demand
FROM top_skills
INNER JOIN 
    skills_dim AS skills ON skills.skill_id = top_skills.skill_id 
ORDER BY 
    demand DESC 
LIMIT 20;
```

**Here's what we learned about the most in-demand skills for Data Scientists in 2023:**

- Foundational Duo: SQL and Python are by far the most requested skills across all Data Scientist roles, highlighting their non-negotiable status.

- Cloud is No Longer Optional: AWS, GCP, and Azure are among the top 10, showcasing the shift toward cloud-first data teams.

- Visualization Matters: Tools like Tableau and Power BI show up frequently, indicating that even technical roles need to communicate insights visually.

- AutoML on the Rise: Appearances of DataRobot and H2O.ai in the top 20 suggest growing interest in automation tools within hiring pipelines.

### 4. Highest Paying Skills

We look at the average salary associated with each skill across all relevant job postings.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

**Here's the breakdown of the highest-paying skills for Data Scientists:**

- Niche Pays Off: Tools like Couchbase, PySpark, and Databricks average salaries above $200K, reflecting a premium for niche big-data expertise.

- AI/ML Premium: Libraries and platforms such as TensorFlow, Keras, and DataRobot show high average salaries—employers value production-ready ML skills.

- Cloud/Infra Blend: High averages for Kubernetes, GitLab, and Elasticsearch indicate that data engineers with DevOps/cloud skills are in demand.

### 5. Most Optimal Skills

Combines salary and demand to find high-value skills that are both well-paid and commonly requested.

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_dim.skill_id
),

-- Skills with high average salaries for Data Scientist roles
-- Using Query #4

average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True 
    GROUP BY
        skills_job_dim.skill_id
)

-- Return high demand and high salaries for 10 skills 

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

![Most Optimal Skills](/assets/query_5.png)


**Here’s the breakdown of the most optimal skills to learn:**

- Best of Both Worlds: Skills like Snowflake, BigQuery, and Azure have high demand + high average salary, making them smart upskilling targets.

- Evergreen Stack: SQL and Python are the only skills to appear in every list, proving their enduring and scalable value.

- Modern Analytics Tools: Tools like Looker, Git, and Kubernetes bridge the gap between analytics, cloud, and automation.

### 6. Top Hiring Companies

Identifies which companies hire the most Data Scientists and what their average pay looks like.

```sql
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
```

**Key Insights:**

- Hiring Volume Leaders: Walmart, Algo Capital, and Selby Jennings top the list, indicating aggressive hiring across retail, crypto, and consulting.

- Quality + Quantity: These companies also offer competitive average salaries, proving high headcount doesn’t mean lower pay.

- Strategic Growth: Recurring presence of companies across multiple queries suggests strategic expansion of data teams, not just turnover.

### 7. Job Location vs Average Salary

Analyzes if location has any influence on the average salary.

```sql
SELECT 
    job_location, 
    COUNT(*) AS num_jobs,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
WHERE job_title='Data Scientist' AND salary_year_avg IS NOT NULL
GROUP BY job_location, job_title_short
ORDER BY avg_salary DESC;
```

**Key Insights:**

- Remote Tops the List: Jobs labeled "Anywhere" have the highest average salaries, proving geography-agnostic hiring can still attract top dollar.

- Metro Premium Still Exists: New York and San Francisco remain strong in both salary and job count.

- Location Disparity: Smaller or inland cities often offer lower salaries and fewer opportunities, hinting at tech centralization despite remote flexibility.

# What I Learned

- How to structure complex SQL queries using `WITH`, `JOIN`, and subqueries
- The importance of combining multiple tables to generate deeper insights
- SQL best practices for readability, reusability, and analysis
- How to create meaningful commentary from raw numbers

# Conclusion

This project was an incredible hands-on experience in SQL. It not only sharpened my querying skills but also provided a data-driven lens into the Data Science job market.

From identifying top-paying roles to pinpointing the most optimal skills, this project revealed:

- 🐍 **Python and SQL** remain foundational for Data Science.
- ☁️ **Cloud platforms and ML libraries** offer higher pay.
- 🎯 Understanding employer needs is key for focused upskilling.

💡 Whether you're just starting or trying to level up as a Data Scientist, these insights offer a clear roadmap for skill-building and job targeting.