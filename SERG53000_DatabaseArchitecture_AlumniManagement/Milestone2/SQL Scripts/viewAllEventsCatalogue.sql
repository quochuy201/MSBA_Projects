
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
ON c.country_id = cn.country_id 