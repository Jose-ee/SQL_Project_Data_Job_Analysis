-- What are the skills required for these top-paying roles?

with top_paying_jobs as(
    select 
        job_id,
        job_title,
        salary_year_avg,
    name as company_name,
    job_location
    from 
        job_postings_fact
    left join 
        company_dim on company_dim.company_id = job_postings_fact.company_id
    where 
        job_title_short = 'Data Analyst' and (
        salary_year_avg is not NULL and
        job_country = 'Belgium'
        )
    order by 
        salary_year_avg desc
limit 10
) 
select 
    top_paying_jobs.*,
    skills
from top_paying_jobs
INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

