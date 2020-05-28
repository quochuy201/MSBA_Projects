
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
COMMENT 'This stored procedure allows the user to create an event and invite all alumni from a program.spInviteProgramAlumniToEvent'
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
                    
                    
