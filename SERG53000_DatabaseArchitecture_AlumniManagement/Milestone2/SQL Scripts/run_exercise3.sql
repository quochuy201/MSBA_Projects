CALL `segr5300`.`spInviteProgramAlumniToEvent`("Class Reunion", 
											'2019-06-04  16:30:00', 
                                           '2019-06-04  21:30:00',
                                           'Pacific Hall',
                                          17,
                                          6, 'MSBA');
use segr5300;
select ae.*,
		a.alumni_id, p.program_name
from alum_events ae inner join alumni a on a.alumni_id = ae.alumni_id
					inner join alum_program ap on a.alumni_id = ap.alumni_id
                    inner join program  p  on p.program_id = ap.program_id
where ae.all_events_id =18;


CALL `segr5300`.`spFindAlumniByDepartment`(12);

select * from
`segr5300`.`viewdonationbycampaign`;

SELECT *
FROM `segr5300`.`viewalleventscatalogue`;

select *
from `segr5300`.`viewtop5donation`;












