---FinalNormalizeData view
---This view is a normalized version of final dataset. We used this view for clustering section.

USE [19su5510_lehuy]
GO

/****** Object:  View [dbo].[FinalNormalizedData]    Script Date: 8/12/2019 4:34:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[FinalNormalizedData]
as
select ParcelNumber, (cast(f.Buildings as float) - 0)/(10-0)  as Buildings
, (f.LandNetSquareFeet - 1500)/(4316796-1500)  as LandNetSquareFeet
			, (f.SquareFeet - 192)/(7230-192) as SquareFeet
			, (cast(f.PhysicalAge as float) - 0)/(119-0)   as PhysicalAge
			, (cast(f.YearBuilt as float) - 1890)/(2019-1890) as YearBuilt
			, (cast(f.YearRemodeled as float)- 0)/(2019-0) as YearRemodeled
			, (f.TaxableValueCurrentYear - 0)/(1979600-0)  as TaxableValueCurrentYear
			, (f.TaxableValuePriorYear - 0)/(1882900-0)  as TaxableValuePriorYear
			, (cast(f.DrugCrime as float)- 0)/(51-0) as DrugCrime
			, (cast(f.Homicide as float) - 0)/(2-0) as Homicide
			, (cast(f.PropertyCrime as float)- 0)/(459-0)   as PropertyCrime
			, (cast(f.PersonalCrime as float)- 0)/(108-0) as PersonalCrime
			, (cast(f.OtherCrime as float)- 0)/(393-0)  as OtherCrime
			, (f.SalePrice - 500)/(21700000-500)  as SalePrice
			, f.SaleDate, f.Condition, f.Quality
from FinalData0809 f
GO


---Finally, We used visual studio SQL data tool to cluster final dataset, then create data with cluster column. 
