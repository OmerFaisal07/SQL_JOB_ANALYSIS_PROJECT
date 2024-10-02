/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/
WITH skill_demand AS (
    SELECT
        skill_to_job.skill_id,
        skills.skills AS skill, -- Assuming 'skills' refers to 'skill_name'
        COUNT(skill_to_job.job_id) AS total_jobs
    FROM job_postings_fact AS jobs
    INNER JOIN skills_job_dim AS skill_to_job
        ON jobs.job_id = skill_to_job.job_id
    INNER JOIN skills_dim AS skills 
        ON skill_to_job.skill_id = skills.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skill_to_job.skill_id,
        skills.skills
), average_salary AS (
    SELECT
        skill_to_job.skill_id,
        skills.skills AS skill, -- Assuming 'skills' refers to 'skill_name'
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact AS jobs
    INNER JOIN skills_job_dim AS skill_to_job
        ON jobs.job_id = skill_to_job.job_id
    INNER JOIN skills_dim AS skills 
        ON skill_to_job.skill_id = skills.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skill_to_job.skill_id,
        skills.skills
)

SELECT
    skill_demand.skill_id,
    skill_demand.skill,  -- Explicit reference to avoid ambiguity
    skill_demand.total_jobs,
    average_salary.avg_salary
FROM skill_demand
INNER JOIN average_salary
    ON skill_demand.skill_id = average_salary.skill_id
WHERE
    skill_demand.total_jobs > 10
ORDER BY
    average_salary.avg_salary DESC,
    skill_demand.total_jobs DESC
LIMIT 25

/*
Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
High-Demand Programming Languages: Python and R stand out for their high demand, with demand counts of 236 and 148 respectively. Despite their high demand, their average salaries are around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued but also widely available.
Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show significant demand with relatively high average salaries, pointing towards the growing importance of cloud platforms and big data technologies in data analysis.
Business Intelligence and Visualization Tools: Tableau and Looker, with demand counts of 230 and 49 respectively, and average salaries around $99,288 and $103,795, highlight the critical role of data visualization and business intelligence in deriving actionable insights from data.
Database Technologies: The demand for skills in traditional and NoSQL databases (Oracle, SQL Server, NoSQL) with average salaries ranging from $97,786 to $104,534, reflects the enduring need for data storage, retrieval, and management expertise.

Results
=

[
  {
    "skill_id": 8,
    "skill": "go",
    "total_jobs": "27",
    "avg_salary": "115320"
  },
  {
    "skill_id": 234,
    "skill": "confluence",
    "total_jobs": "11",
    "avg_salary": "114210"
  },
  {
    "skill_id": 97,
    "skill": "hadoop",
    "total_jobs": "22",
    "avg_salary": "113193"
  },
  {
    "skill_id": 80,
    "skill": "snowflake",
    "total_jobs": "37",
    "avg_salary": "112948"
  },
  {
    "skill_id": 74,
    "skill": "azure",
    "total_jobs": "34",
    "avg_salary": "111225"
  },
  {
    "skill_id": 77,
    "skill": "bigquery",
    "total_jobs": "13",
    "avg_salary": "109654"
  },
  {
    "skill_id": 76,
    "skill": "aws",
    "total_jobs": "32",
    "avg_salary": "108317"
  },
  {
    "skill_id": 4,
    "skill": "java",
    "total_jobs": "17",
    "avg_salary": "106906"
  },
  {
    "skill_id": 194,
    "skill": "ssis",
    "total_jobs": "12",
    "avg_salary": "106683"
  },
  {
    "skill_id": 233,
    "skill": "jira",
    "total_jobs": "20",
    "avg_salary": "104918"
  },
  {
    "skill_id": 79,
    "skill": "oracle",
    "total_jobs": "37",
    "avg_salary": "104534"
  },
  {
    "skill_id": 185,
    "skill": "looker",
    "total_jobs": "49",
    "avg_salary": "103795"
  },
  {
    "skill_id": 2,
    "skill": "nosql",
    "total_jobs": "13",
    "avg_salary": "101414"
  },
  {
    "skill_id": 1,
    "skill": "python",
    "total_jobs": "236",
    "avg_salary": "101397"
  },
  {
    "skill_id": 5,
    "skill": "r",
    "total_jobs": "148",
    "avg_salary": "100499"
  },
  {
    "skill_id": 78,
    "skill": "redshift",
    "total_jobs": "16",
    "avg_salary": "99936"
  },
  {
    "skill_id": 187,
    "skill": "qlik",
    "total_jobs": "13",
    "avg_salary": "99631"
  },
  {
    "skill_id": 182,
    "skill": "tableau",
    "total_jobs": "230",
    "avg_salary": "99288"
  },
  {
    "skill_id": 197,
    "skill": "ssrs",
    "total_jobs": "14",
    "avg_salary": "99171"
  },
  {
    "skill_id": 92,
    "skill": "spark",
    "total_jobs": "13",
    "avg_salary": "99077"
  },
  {
    "skill_id": 13,
    "skill": "c++",
    "total_jobs": "11",
    "avg_salary": "98958"
  },
  {
    "skill_id": 186,
    "skill": "sas",
    "total_jobs": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 7,
    "skill": "sas",
    "total_jobs": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 61,
    "skill": "sql server",
    "total_jobs": "35",
    "avg_salary": "97786"
  },
  {
    "skill_id": 9,
    "skill": "javascript",
    "total_jobs": "20",
    "avg_salary": "97587"
  }
]
*/