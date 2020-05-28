use `segr5300`;

/* # fetch top 3 cities where donation is maximum
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
limit 3; */

# After deciding the city, now we want all the details from that city
select 	c.city_name as 'City Name',
		a.alumni_name as 'Alumni Name',
        a.alumni_emailID as 'Email ID',
        GROUP_CONCAT(ale.all_events_name SEPARATOR ', ') as 'Events Attended',
        p.program_name as 'Program Name',
        ad.alumni_donation_amount as 'Donation Amount',
        co.company_name as 'Company Name',
        city_3.adm as 'Total Donation',
        city_3.noc as 'No of Companies',
        city_3.noa as 'No of Alumni'
from city as c
inner join alumni as a
on c.city_id = a.city_id
left outer join alum_events as ae
on a.alumni_id = ae.alumni_id
left outer join all_events as ale
on ae.all_events_id = ale.all_events_id
inner join alum_program as ap
on a.alumni_id = ap.alumni_id
inner join program as p
on ap.program_id = p.program_id
left outer join alumni_donation as ad
on a.alumni_id = ad.alumni_id
left outer join company as co
on a.company_id = co.company_id
inner join (select 	c.city_id, 
		c.city_name,
        SUM(ad.alumni_donation_amount) as adm,
        ci_co.no_comp as noc,
        ci_al.no_alumni as noa
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
limit 3) as city_3
on c.city_id = city_3.city_id
group by a.alumni_name;

/* # select no of companies in each city
select c.city_id as 'city_id', COUNT(co.company_name) as 'no_comp'
from city as c
inner join alumni as a
on c.city_id = a.city_id
inner join company as co
on a.company_id = co.company_id
group by c.city_name;

# Number of contacts in each city
select c.city_id as 'city_id', COUNT(a.alumni_id) as 'no_alumni'
from city as c
inner join alumni as a
on c.city_id = a.city_id
group by c.city_name; */
