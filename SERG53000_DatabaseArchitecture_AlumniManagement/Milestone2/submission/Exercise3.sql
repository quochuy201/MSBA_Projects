use segr5300;

-- Stored Procedures

-- SP 1
-- based on an insert or update, 
-- should have at least one input parameter

DROP PROCEDURE IF EXISTS spInviteProgramAlumniToEvent;

DELIMITER $$
CREATE PROCEDURE spInviteProgramAlumniToEvent(
				event_name VARCHAR(50),
                event_start_DT DATETIME,
                event_end_DT DATETIME,
                event_location VARCHAR(50),
                event_department_id INT,
                event_city_id INT,
                my_program_name VARCHAR(50)
                )
COMMENT 'This stored procedure allows the user to create an event and invite all alumni from a program.'
BEGIN

INSERT INTO `segr5300`.`all_events`
(`all_events_name`,
`all_events_start_time`,
`all_events_end_time`,
`all_events_address`,
`department_id`,
`city_id`)
VALUES
(event_name,
event_start_DT,
event_end_DT,
event_location,
event_department_id,
event_city_id);


SET @event_id = (SELECT LAST_INSERT_ID());

INSERT INTO `segr5300`.`alum_events`
(`all_events_id`,`alumni_id`,`attended`)
SELECT @event_id, a.alumni_id, 0
FROM alum_program ap
LEFT JOIN alumni a
ON ap.alumni_id = a.alumni_id
WHERE program_id IN (SELECT program_id 
					FROM program
					WHERE program_name = my_program_name);

END$$
DELIMITER ;                  
                    

-- SP 2
-- based on an select, 
-- should contain a join and a subquery, 
-- should have at least one input parameter

DROP PROCEDURE IF EXISTS spFindAlumniByDepartment;

DELIMITER $$
CREATE PROCEDURE spFindAlumniByDepartment(
				dept_id INT
                )
COMMENT 'This stored procedure allows the user to retrieve all alumni from a department.'
COMMENT 'EXAMPLE CALL -> CALL spFindAlumniByDepartment(5)'
BEGIN

SET @dept_name = (SELECT department_name from department where department_id = dept_id);

SELECT alumni_name, alumni_emailID, alumni_designation, 
		c.company_name, @dept_name as department
FROM alumni a
LEFT JOIN alum_program ap
ON a.alumni_id = ap.alumni_id
LEFT JOIN company c
ON a.company_id = c.company_id
WHERE ap.program_id IN (SELECT program_id FROM program WHERE department_id = dept_id);

END$$
DELIMITER ;                  

-- Views

-- View 1 - Aggregation & Join
DROP VIEW IF EXISTS viewAlumniProfileSnapshot;

CREATE VIEW viewAlumniProfileSnapshot AS

SELECT a.alumni_id, a.alumni_student_id, a.alumni_name, a.alumni_emailID,
		alumni_contact_no as contact_no, alumni_postal_street_address as address, 
        alumni_postal_zip as zip_code,
        city_name as city, company_name as company,
		COALESCE(donations.total_donation,0) as total_donations, 
        COALESCE(evnts.events_attended,0) as events_attended,
        COALESCE(prgms.programs_attended,0) as programs_attended
FROM alumni a
LEFT JOIN (SELECT alumni_id, SUM(alumni_donation_amount) as total_donation 
		   FROM alumni_donation 
           GROUP BY alumni_id) as donations 
ON a.alumni_id = donations.alumni_id
LEFT JOIN (SELECT alumni_id, COUNT(alum_events_id) as events_attended 
		   FROM alum_events 
           WHERE attended=1 
           GROUP BY alumni_id) as evnts 
ON a.alumni_id = evnts.alumni_id
LEFT JOIN (SELECT alumni_id, COUNT(program_id) as programs_attended 
		   FROM alum_program 
           GROUP BY alumni_id) as prgms 
ON a.alumni_id = prgms.alumni_id
LEFT JOIN city 
ON a.city_id = city.city_id
LEFT JOIN company cmp
ON a.company_id = cmp.company_id;

-- View 2 - Joins
DROP VIEW IF EXISTS viewAllEventsCatalogue;

CREATE VIEW viewAllEventsCatalogue AS

SELECT e.all_events_name, DATE_FORMAT(e.all_events_start_time, '%e %b %Y') as event_date,
	DATE_FORMAT(e.all_events_start_time, '%r') as event_start_time,
    DATE_FORMAT(e.all_events_end_time, '%r') as event_end_time,
    department_name as host_department,
    all_events_address as location, city_name, country_name
FROM all_events e
LEFT JOIN department d
ON e.department_id = d.department_id
LEFT JOIN city c
ON e.city_id = c.city_id
LEFT JOIN country cn
ON c.country_id = cn.country_id; 

-- View 3 - Sub-Query
DROP VIEW IF EXISTS viewTop5Donation;

CREATE  VIEW viewTop5Donation AS 

SELECT a.alumni_name, Total_Donation
FROM alumni a
RIGHT JOIN (SELECT alumni_id, 
			SUM(alumni_donation_amount) AS Total_Donation
			FROM alumni_donation d
			GROUP BY alumni_id
			ORDER BY Total_Donation DESC
			LIMIT 5) AS d
ON a.alumni_id = d.alumni_id


