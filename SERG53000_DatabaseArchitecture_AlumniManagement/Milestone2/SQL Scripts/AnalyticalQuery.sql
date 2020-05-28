# SEGR5300 MILESTONE 2
# 
# 4. ANALYTIC QUERIES and Integration into TABLEAU or EXCEL
# Group 4: Sanyukta Ghai, Sourabh Gupta, Huy Le
# 

# select event information and number of attendancce
/* Add column headers */
SELECT 'Event ID','Event Name','Event address','Event Start Time','Number of Attendance'
Union all
/* Now the actual query */
select ae.all_events_id, ae.all_events_name, ae.all_events_address, ae.all_events_start_time, ale.NoAttendance
from all_events ae inner join 
			(select count(*) as NoAttendance, ales.all_events_id
			from alum_events ales 
			where ales.attended =1
			group by ales.all_events_id) ale 	
        on ae.all_events_id = ale.all_events_id;
/* Save the query results to a file */ 
/*optional
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/allevents.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
*/
##########################################################################################
# aggregate total alumni and donation by department.
SELECT 'Department ID','Department Name','Number of Alumni','Total Alumni Donation'
Union all
select d.department_id, d.department_name,count(a.alumni_id) as no_alumni, sum(ad.alumni_donation_amount) as total_donation
from alumni a inner join alum_program al on a.alumni_id = al.alumni_id
			inner join program p on al.program_id	= p.program_id
            inner join department d on p.department_id = d.department_id
            inner join company c on a.company_id = c.company_id
            inner join alumni_donation ad on ad.alumni_id = a.alumni_id
group by d.department_id,d.department_name;
/* Save the query results to a file */
/*optional
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dept_alum_donate.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
*/
##########################################################################################
# 
