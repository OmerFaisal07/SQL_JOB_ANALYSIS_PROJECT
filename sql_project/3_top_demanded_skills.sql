/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(skill_to_job.job_id) AS total_jobs
FROM job_postings_fact AS jobs
INNER JOIN skills_job_dim AS skill_to_job
    ON jobs.job_id = skill_to_job.job_id
INNER JOIN skills_dim AS skills 
    ON skill_to_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_via = 'via LinkedIn'
GROUP BY
    skills
ORDER BY
    total_jobs DESC
LIMIT 5

/*
Here's the breakdown of the most demanded skills for data analysts in 2023 via Linkedin:
SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

Results
=

  {
    "skills": "sql",
    "total_jobs": "22427"
  },
  {
    "skills": "excel",
    "total_jobs": "14828"
  },
  {
    "skills": "python",
    "total_jobs": "13525"
  },
  {
    "skills": "tableau",
    "total_jobs": "11177"
  },
  {
    "skills": "power bi",
    "total_jobs": "9400"
  }
]