CREATE VIEW `segr5300`.`noalum_dept` AS 
select `d`.`department_name` AS `department_name`,
		`a`.`num_alumni` AS `num_alumni` 
from ((`segr5300`.`department` `d` left join 
		`segr5300`.`program` `p` on((`d`.`department_id` = `p`.`department_id`))) join 
        (	select `ap`.`program_id` AS `program_id`,count(0) AS `num_alumni` 
			from `segr5300`.`alum_program` `ap` 
            group by `ap`.`program_id`) `a` on((`p`.`program_id` = `a`.`program_id`)));
