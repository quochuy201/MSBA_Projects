---6.	GroupedDataWithSale view
---This view is the data in groupeddatafull integrated with sale data. We integrated crime data in previous step with the house's attributes and sale data.
---We only select those most recent sale data from 01-01-2018 until now because we wanted to predict 2019 price.
USE [19su5510_lehuy]
GO
/****** Object:  View [dbo].[GroupedDatawithSale]    Script Date: 8/12/2019 4:32:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [dbo].[GroupedDatawithSale]
as
select a.ParcelNumber,
		a.Buildings,
		a.LandNetSquareFeet,
		a.SquareFeet,
		a.Condition,
		a.Quality,
		a.PhysicalAge,
		a.YearBuilt,
		a.YearRemodeled,
		a.TaxableValueCurrentYear,
		a.TaxableValuePriorYear,
		isnull(a.DrugCrime,0) as DrugCrime,
		isnull(a.Homicide,0) as Homicide,
		isnull(a.PropertyCrime,0)as PropertyCrime,
		isnull(a.PersonalCrime,0) as PersonalCrime,
		isnull(a.OtherCrime,0) as OtherCrime, s.SalePrice, s.SaleDate
from groupeddatatull a inner join
	(select ParcelNumber, SalePrice, SaleDate
	from(
		select Row_number()
			OVER (
			partition BY (Sale.ParcelNumber)
			ORDER BY Sale.SaleDate Desc) SaleOrder, ParcelNumber, SaleDate,SalePrice
		from Sale) so 
	where SaleOrder=1) s on a.ParcelNumber = s.ParcelNumber
where s.SaleDate >='2018-01-01'
GO

---After having a view with final data, we insert those data into table FinalData0809. To keep this dataset constant
