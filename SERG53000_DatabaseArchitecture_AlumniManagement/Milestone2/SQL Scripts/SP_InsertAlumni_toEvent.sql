DELIMITER $$
CREATE PROCEDURE `insert_alum_even`(
		IN 	event_id  VARCHAR(25),
         program_name varchar(50))
begin
	INSERT INTO alum_events(alum_events_id,
							all_events_id,
							alumni_id,
							attended)
	select @row := @row + 1 as alum_events_id,
			event_id, 
			a.alumni_id, 
			1 as  attended
	from alumni a inner join alum_program ap on a.alumni_id = ap.alumni_id
					inner join program p on ap.program_id = p.program_id, (SELECT @row := max(alum_events_id) 
						from   alum_events) r
	where a.alumni_id not in (
		select distinct alumni_id 
		from alum_events ae
		where all_events_id =event_id) and p.program_name like concat('%',program_name,'%') ;

end$$
DELIMITER ;
