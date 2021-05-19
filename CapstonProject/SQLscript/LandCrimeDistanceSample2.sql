---	Calculate distance between filtered Property and Crime data and insert into a table for the following steps
--- because the limited in resouces, we were not able to run the calculation for entire pierce county. We decided to run it within certain areas.

insert into [dbo].[LandCrimeDistanceSample2]
select ta.ParcelNumber, d.OBJECTID,
	ta.Latitude,ta.Longtitude, d.lattitude, d.longtitude,
	 [dbo].[getDistanceSTDistanceMile](ta.Latitude,ta.Longtitude, d.lattitude, d.longtitude) as Distance
from
		(select a.ParcelNumber, a.Latitude as Latitude, a.Longtitude as Longtitude, ap.ZipCode
		from AppraisalAccount a inner join Sale s on a.ParcelNumber= s.ParcelNumber	
				left join AddressPoint ap on a.ParcelNumber= ap.ParcelNumber
		where  s.SaleDate >='2018-01-01' and
				ap.ZipCode in ('98328',	'98338','98375','98387',
							'98385','98448','98374','98373','98446',
							'98445','98444','98467','98464','98371',
							'98466','98391','98372','98335','98335',
							'98394','98332','98329')
		) ta , 
		(select * from CrimeData) d

