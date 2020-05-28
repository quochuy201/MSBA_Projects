# SEGR5300 MILESTONE 2
# 
# 4. ANALYTIC QUERIES and Integration into TABLEAU or EXCEL
# Group 9: Sanyukta Ghai, Sourabh Gupta, Huy Le
# 

# select event information and number of attendancce
/* Now the actual query */
select ae.all_events_id, ae.all_events_name, ae.all_events_address, ae.all_events_start_time, ale.NoAttendance
from all_events ae inner join 
			(select count(*) as NoAttendance, ales.all_events_id
			from alum_events ales 
			where ales.attended =1
			group by ales.all_events_id) ale 	
        on ae.all_events_id = ale.all_events_id;
##########################################################################################
# aggregate total alumni and donation by department.

select d.department_id, d.department_name,count(a.alumni_id) as no_alumni, sum(ad.alumni_donation_amount) as total_donation
from alumni a inner join alum_program al on a.alumni_id = al.alumni_id
			inner join program p on al.program_id	= p.program_id
            inner join department d on p.department_id = d.department_id
            inner join company c on a.company_id = c.company_id
            inner join alumni_donation ad on ad.alumni_id = a.alumni_id
group by d.department_id,d.department_name;

##########################################################################################
# fetch top 3 cities where donation is maximum
select 	c.city_id, 
		c.city_name,
        SUM(ad.alumni_donation_amount) as 'Total Donation',
        ci_co.no_comp as 'No of Companies',
        ci_al.no_alumni as 'No of Alumni'
from city as c
inner join alumni as a
on c.city_id = a.city_id
inner join alumni_donation as ad
on a.alumni_id = ad.alumni_id
inner join (select c.city_id as 'city_id', COUNT(co.company_name) as 'no_comp'
				from city as c
				inner join alumni as a
				on c.city_id = a.city_id
				inner join company as co
				on a.company_id = co.company_id
				group by c.city_name) as ci_co
on c.city_id = ci_co.city_id 
inner join (select c.city_id as 'city_id', COUNT(a.alumni_id) as 'no_alumni'
				from city as c
				inner join alumni as a
				on c.city_id = a.city_id
				group by c.city_name) as ci_al
on c.city_id = ci_al.city_id
group by c.city_name
order by ci_co.no_comp desc, SUM(ad.alumni_donation_amount) desc
limit 3;

##########################################################################################
# After deciding the city, now we want all the details from that city
SELECT 
    c.city_name AS 'City Name',
    a.alumni_name AS 'Alumni Name',
    a.alumni_emailID AS 'Email ID',
    GROUP_CONCAT(ale.all_events_name
        SEPARATOR ', ') AS 'Events Attended',
    p.program_name AS 'Program Name',
    ad.alumni_donation_amount AS 'Donation Amount',
    co.company_name AS 'Company Name',
    city_3.adm AS 'Total Donation',
    city_3.noc AS 'No of Companies',
    city_3.noa AS 'No of Alumni'
FROM
    city AS c
        INNER JOIN
    alumni AS a ON c.city_id = a.city_id
        LEFT OUTER JOIN
    alum_events AS ae ON a.alumni_id = ae.alumni_id
        LEFT OUTER JOIN
    all_events AS ale ON ae.all_events_id = ale.all_events_id
        INNER JOIN
    alum_program AS ap ON a.alumni_id = ap.alumni_id
        INNER JOIN
    program AS p ON ap.program_id = p.program_id
        LEFT OUTER JOIN
    alumni_donation AS ad ON a.alumni_id = ad.alumni_id
        LEFT OUTER JOIN
    company AS co ON a.company_id = co.company_id
        INNER JOIN
    (SELECT 
        c.city_id,
            c.city_name,
            SUM(ad.alumni_donation_amount) AS adm,
            ci_co.no_comp AS noc,
            ci_al.no_alumni AS noa
    FROM
        city AS c
    INNER JOIN alumni AS a ON c.city_id = a.city_id
    INNER JOIN alumni_donation AS ad ON a.alumni_id = ad.alumni_id
    INNER JOIN (SELECT 
        c.city_id AS 'city_id', COUNT(co.company_name) AS 'no_comp'
    FROM
        city AS c
    INNER JOIN alumni AS a ON c.city_id = a.city_id
    INNER JOIN company AS co ON a.company_id = co.company_id
    GROUP BY c.city_name) AS ci_co ON c.city_id = ci_co.city_id
    INNER JOIN (SELECT 
        c.city_id AS 'city_id', COUNT(a.alumni_id) AS 'no_alumni'
    FROM
        city AS c
    INNER JOIN alumni AS a ON c.city_id = a.city_id
    GROUP BY c.city_name) AS ci_al ON c.city_id = ci_al.city_id
    GROUP BY c.city_name
    ORDER BY ci_co.no_comp DESC , SUM(ad.alumni_donation_amount) DESC
    LIMIT 3) AS city_3 ON c.city_id = city_3.city_id
GROUP BY a.alumni_name;