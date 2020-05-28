
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