CREATE VIEW `segr5300`.`alumni_info` AS 
select `a`.`alumni_id` AS `alumni_id`,
		`a`.`alumni_student_id` AS `alumni_student_id`,
        `a`.`alumni_name` AS `alumni_name`,
        `a`.`alumni_emailID` AS `alumni_emailID`,
        `a`.`alumni_contact_no` AS `alumni_contact_no`,
        `c`.`company_name` AS `company_name`,
        `p`.`program_name` AS `program_name`,
        `al`.`alum_program_grad_year` AS `alum_program_grad_year`,
        `d`.`department_name` AS `department_name` 
from ((((`segr5300`.`alumni` `a` join 
			`segr5300`.`alum_program` `al` on((`a`.`alumni_id` = `al`.`alumni_id`))) join 
            `segr5300`.`program` `p` on((`al`.`program_id` = `p`.`program_id`))) join 
            `segr5300`.`department` `d` on((`p`.`department_id` = `d`.`department_id`))) join 
            `segr5300`.`company` `c` on((`a`.`company_id` = `c`.`company_id`)));

