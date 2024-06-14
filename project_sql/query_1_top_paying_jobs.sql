

-- What are the top-paying jobs for my role?

select 
    name,
    job_title,
    salary_year_avg,
    job_location,
    job_schedule_type
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

