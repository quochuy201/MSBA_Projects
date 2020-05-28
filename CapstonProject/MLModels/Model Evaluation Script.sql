/*Denormalized Data*/
select *
into crime_data_full
from [19su5510_tolenti4].[dbo].[grouped_data_full];

select *
into crime_data_full_testing
from crime_data_full
tablesample(30 percent);

select *
into crime_data_full_training
from crime_data_full c
where c.ParcelNumber not in
		(select test.ParcelNumber from crime_data_full_testing test);

select count(*) [Number of Rows]
from crime_data_full;

select count(*) [Number of Rows]
from crime_data_full_testing;

select count(*) [Number of Rows]
from crime_data_full_training;

/*Convert TaxableValueCurrentYear into a Numeric Data Type*/
select *, convert(decimal(16,4), TaxableValueCurrentYear) AS TaxableValueCurrentYearNum
into crime_data_full_norm
from [19su5510_tolenti4].[dbo].[grouped_data_full];

/*Normalize Data*/
select max(TaxableValueCurrentYearNum) maxTax, min(TaxableValueCurrentYearNum) minTax
from crime_data_full_norm;
select AVG(TaxableValueCurrentYearNum) avgTax, STDEV(TaxableValueCurrentYearNum) stdevTax
from crime_data_full_norm;

select ParcelNumber, TaxableValueCurrentYearNum, 
	   (TaxableValueCurrentYearNum - 0)/(1588500 - 0) as minmaxTax,
	   (TaxableValueCurrentYearNum - 330858.583120)/114084.87354615 as stdevTax
from crime_data_full_norm;

/*Create View of Normalized Data*/
create view CrimeNorm as
select *, (TaxableValueCurrentYearNum - 0)/(1588500 - 0) as minmaxTax,
	   (TaxableValueCurrentYearNum - 330858.583120)/114084.87354615 as stdevTax
from crime_data_full_norm;
go
select * from CrimeNorm

/*Create Testing & Training Tables from Normalized Data*/
select *
into crimeNormalized
from [19su5510_tolenti4].[dbo].[CrimeNorm];

select *
into crimeNormTesting
from crimeNormalized
tablesample(30 percent);

select *
into crimeNormTraining
from crimeNormalized c
where c.ParcelNumber not in
		(select test.ParcelNumber from crimeNormTesting test);

select count(*) [Number of Rows]
from crimeNormalized;

select count(*) [Number of Rows]
from crimeNormTesting;

select count(*) [Number of Rows]
from crimeNormTraining;

/*Create a View and Calculate MSE from DTree*/
create view mseCrimeNormDTree as
select square([ActualTaxValue] - [PredTaxValue]) [SqError]
from [dbo].[CrimeNormDTreeResults];

select count(*)
from mseCrimeNormDTree;

select sum([SqError])/count(*) [MSE_DTree]
from mseCrimeNormDTree;

/*Create a View and Calculate MSE from NN*/
create view mseCrimeNormNN as
select square([ActualTaxValue] - [PredTaxValue]) [SqError]
from [dbo].[CrimeNormNNResults];

select count(*)
from mseCrimeNormNN;

select sum([SqError])/count(*) [MSE_NN]
from mseCrimeNormNN;