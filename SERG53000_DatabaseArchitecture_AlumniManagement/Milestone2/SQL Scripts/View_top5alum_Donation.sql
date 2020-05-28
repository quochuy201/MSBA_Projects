CREATE  VIEW `segr5300`.`topfivedonation` AS 
select `r`.`alumni_id` AS `alumni_id`,
		`a`.`alumni_name` AS `alumni_name`,
		`a`.`alumni_student_id` AS `alumni_student_id`,
        `r`.`total_donate` AS `total_donate` 
from ((	select `d`.`total_donate` AS `total_donate`,
				`d`.`alumni_id` AS `alumni_id`,
				rank() OVER (ORDER BY `d`.`total_donate` desc )  AS `donate_rank` 
		from (	select sum(`segr5300`.`alumni_donation`.`alumni_donation_amount`) AS `total_donate`,
						`segr5300`.`alumni_donation`.`alumni_id` AS `alumni_id` 
				from `segr5300`.`alumni_donation` 
                group by `segr5300`.`alumni_donation`.`alumni_id` 
                order by `segr5300`.`alumni_donation`.`alumni_id`) `d`) `r` join 
		`segr5300`.`alumni` `a` on((`r`.`alumni_id` = `a`.`alumni_id`))) 
where (`r`.`donate_rank` <= 5);
