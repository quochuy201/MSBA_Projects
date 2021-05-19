---CompiledDataVersion1 view
---This view gather all chosen fields of property into one place
USE [19su5510_lehuy]
GO

/****** Object:  View [dbo].[CompiledDataVersion1]    Script Date: 8/12/2019 4:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CompiledDataVersion1]
as
select 
	a.ParcelNumber, 
	a.AppraisalAccountType, 
	a.Buildings, 
	a.LandGrossSquareFeet, 
	a.LandNetSquareFeet, 
	a.AppraisalDate, 
	a.Latitude, 
	a.Longtitude,
	b.BuildingID,
	b.PropertyType,
	b.SquareFeet,
	b.PercentComplete,
	b.Condition,
	b.Quality,
	c.PhysicalAge,
	c.YearBuilt,
	c.YearRemodeled,
	d.AccountType,
	d.TaxableValuePriorYear,
	d.TaxableValueCurrentYear,
	e.Zipcode
from dbo.AppraisalAccount a
left join dbo.Improvement b ON b.ParcelNumber = a.ParcelNumber
left join dbo.ImprovementBuiltas c ON c.ParcelNumber = b.ParcelNumber AND c.BuildingID = b.BuildingID
left join dbo.TaxAccount d ON d.ParcelNumber = c.ParcelNumber
left join dbo.AddressPoint e ON e.ParcelNumber = d.ParcelNumber
WHERE a.AppraisalAccountType = 'Residential' AND b.PropertyType = 'Residential' AND d.AccountType = 'REAL'
		AND e.Zipcode in ('98328','98338','98375','98387','98385','98448','98374','98373','98446','98445','98444','98467','98464','98371','98466','98391','98372','98335','98335','98394','98332','98329')
GO
