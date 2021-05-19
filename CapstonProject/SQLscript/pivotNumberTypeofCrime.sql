---Groupeddatafull view
---This view spread crime data in groupedsample view to column. 
---This action is to tidy data table by using pivot function, make every single row is correspond with only one property.
USE [19su5510_lehuy]
GO
/****** Object:  View [dbo].[groupeddatatull]    Script Date: 8/12/2019 4:23:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[groupeddatafull]
as
select a.ParcelNumber, a.AppraisalAccountType,  
    a.Buildings, a.LandGrossSquareFeet,  
    a.LandNetSquareFeet, a.AppraisalDate,  
    a.Latitude,  a.Longtitude, a.BuildingID, a.PropertyType, 
    a.SquareFeet, z.PercentComplete, a.Condition, a.Quality, a.PhysicalAge, 
    a.YearBuilt, a.YearRemodeled, 
    a.AccountType, a.TaxableValuePriorYear, 
    a.TaxableValueCurrentYear, a.Zipcode, b. [DrugCrime], b.[Homicide], b.[OtherCrime], b.[PersonalCrime], b.[PropertyCrime] 
from [dbo].[CompiledDataVersion1] a left join  
(select ParcelNumber,[DrugCrime],[Homicide],[OtherCrime],[PersonalCrime],[PropertyCrime]  
	from  
		(select ParcelNumber, CrimeCategory, NoofCrime  
		from [dbo].[groupedsample] ) as a  
		pivot (max(a.NoofCrime) for a.CrimeCategory in ([DrugCrime],[Homicide],[OtherCrime],[PersonalCrime],[PropertyCrime]))as p ) b 
		on a.ParcelNumber = b.ParcelNumber 
WHERE 
--Zipcode in ('98371', '98372', '98373','98374','98375') and 
		a.ParcelNumber in( select l.ParcelNumber from LandCrimeDistanceSample2 l)
GO

