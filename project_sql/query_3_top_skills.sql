/*
What are the most in-demand skills for data scientists?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data scientist.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/


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

/*
Here's the breakdown of the most demanded skills for Data Scientists in 2023:

Core Programming & Statistical Skills:
**Python** leads by a wide margin with over 114k job mentions, followed by **SQL** and **R**, underscoring their foundational role in data science workflows—from data manipulation to statistical modeling.

Cloud and Big Data Technologies:
High demand for **AWS**, **Azure**, **Spark**, and **Hadoop** illustrates the importance of working with large-scale data in cloud-native environments.

Machine Learning & AI Libraries:
Libraries such as **TensorFlow**, **PyTorch**, **Scikit-learn**, and **Pandas** are in high demand, signaling the increasing focus on ML, deep learning, and model development in real-world applications.

Data Visualization & Reporting:
Skills in **Tableau**, **Excel**, and **Power BI** are valued for presenting insights and building data-driven dashboards, showing that communication of findings remains critical.

Software Development & Version Control:
**Git**, **Java**, and **Scala** rank highly, indicating the growing overlap between data science and software engineering disciplines.

[
  {
    "skill_name": "python",
    "demand": "114016"
  },
  {
    "skill_name": "sql",
    "demand": "79174"
  },
  {
    "skill_name": "r",
    "demand": "59754"
  },
  {
    "skill_name": "tableau",
    "demand": "29513"
  },
  {
    "skill_name": "aws",
    "demand": "26311"
  },
  {
    "skill_name": "spark",
    "demand": "24353"
  },
  {
    "skill_name": "azure",
    "demand": "21698"
  },
  {
    "skill_name": "tensorflow",
    "demand": "19193"
  },
  {
    "skill_name": "excel",
    "demand": "17601"
  },
  {
    "skill_name": "java",
    "demand": "16314"
  },
  {
    "skill_name": "power bi",
    "demand": "15744"
  },
  {
    "skill_name": "hadoop",
    "demand": "15575"
  },
  {
    "skill_name": "pytorch",
    "demand": "15075"
  },
  {
    "skill_name": "pandas",
    "demand": "14866"
  },
  {
    "skill_name": "sas",
    "demand": "14821"
  },
  {
    "skill_name": "git",
    "demand": "12285"
  },
  {
    "skill_name": "scikit-learn",
    "demand": "11636"
  },
  {
    "skill_name": "numpy",
    "demand": "10818"
  },
  {
    "skill_name": "scala",
    "demand": "10416"
  }
]
*/

