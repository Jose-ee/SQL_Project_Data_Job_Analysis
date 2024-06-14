-- What are the top skills based on salary for my role?

SELECT 
    skills,
    round(AVG(salary_year_avg),0) as avg_salary
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where 
        job_title_short = 'Data Analyst' and (
        salary_year_avg is not NULL and
        job_country = 'Belgium'
        )
GROUP BY skills
ORDER BY avg_salary desc