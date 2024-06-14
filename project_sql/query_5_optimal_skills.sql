/* - What are the most optimal skills to learn? 
    - Optimal: high demand and high paying
*/
with skills_demand as(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    from job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    where 
        job_title_short = 'Data Analyst' and (
        salary_year_avg is not NULL and
        job_country = 'Belgium'
        )
    GROUP BY 
        skills_dim.skill_id
),
average_salary as(
    SELECT 
        skills_dim.skill_id,
        round(AVG(salary_year_avg),0) as avg_salary
    from job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    where 
        job_title_short = 'Data Analyst' and (
        salary_year_avg is not NULL and
        job_country = 'Belgium'
        )
    GROUP BY 
        skills_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
From 
    skills_demand
Inner join average_salary on skills_demand.skill_id = average_salary.skill_id
ORDER BY 
    demand_count DESC,
    avg_salary DESC


