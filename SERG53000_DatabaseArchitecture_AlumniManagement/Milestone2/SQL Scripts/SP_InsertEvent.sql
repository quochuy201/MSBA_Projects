DELIMITER $$
CREATE  PROCEDURE `Insert_All_events`(
in events_name varchar(50),
	start_time datetime,
    end_time datetime,
    address varchar(50),
    departmentid varchar(15),
    city varchar(20))
BEGIN
	INSERT INTO `segr5300`.`all_events`
					(`all_events_id`,
					`all_events_name`,
					`all_events_start_time`,
					`all_events_end_time`,
					`all_events_address`,
					`department_id`,
					`city_id`)
		select r.maxid + 1 as all_events_id,
				events_name, 
				start_time, 
				end_time,
				address,
				departmentid,
				city
		from (SELECT max(all_events_id) as maxid
			from   all_events) r;
END$$
DELIMITER ;
