CREATE VIEW MasterData
as
select          ta.ParcelNumber,
				ta.CurrentUseCodeCurrentYear,
				ta.UseCode,
				ta.TaxableValueCurrentYear,
				ta.TaxYearCurrent,
				ta.TaxCodeAreaCurrentYear,
				ta.LandValueCurrentYear,
				ta.ImprovementValueCurrentYear,
				ta.TotalMarketValueCurrentYear,
				ta.TaxableValuePriorYear,
				ta.TaxYearPrior,
				ta.TaxCodeAreaPrior,
				ta.LandValuePriorYear,
				ta.ImprovementValuePriorYear,
				ta.TotalMarketValuePriorYear,
				aa.AppraisalAccountType,
				aa.LandGrossAcres,
				aa.LandNetAcres,
				aa.LandGrossSquareFeet,
				aa.LandNetSquareFeet,
				aa.LandDepth,
				aa.LandWidth,
				aa.AppraisalDate,
				aa.UtilityElectric,
				aa.UtilitySewer,
				aa.UtilityWater,
				aa.StreetType,
				aa.Latitude,
				aa.Longtitude
from TaxAccount ta inner join
		AppraisalAccount aa on ta.ParcelNumber =aa.ParcelNumber