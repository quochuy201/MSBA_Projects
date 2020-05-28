
-- check appraisal account import
select * from AppraisalAccount

select count(*) from AppraisalAccount

select distinct ParcelNumber from AppraisalAccount  with (nolock) 



-- check [Improvement] import
select * from [dbo].[Improvement]

select count(*) from [dbo].[Improvement]

select distinct ParcelNumber,BuildingID from [dbo].[Improvement] 

-- check [dbo].[ImprovementBuiltas] import
select * from [dbo].[ImprovementBuiltas]

select count(*) from [dbo].[ImprovementBuiltas]

select distinct ParcelNumber,BuildingID,BuiltAsNumber from [dbo].[ImprovementBuiltas]

select* from SegMerge
-- check [dbo].[[ImprovementDetail]] import
select * from [dbo].[ImprovementDetail]

select count(*) from [dbo].[ImprovementDetail]

-- check [dbo].[LandAttribute]import
select * from [dbo].[LandAttribute]

select count(*) from [dbo].[LandAttribute]
-- check [dbo].[Sale] import
select * from [dbo].[Sale] 

select count(*) from [dbo].[Sale] 


-- check  [dbo].[SegMerge]import
select * from [dbo].[SegMerge]

select count(*) from [dbo].[SegMerge]


-- check  [dbo].[TaxAccount] import
select * from [dbo].[TaxAccount]

select count(*) from [dbo].[TaxAccount]

-- check  [dbo].[TaxDescription] import
select * from [dbo].[TaxDescription]

select count(*) from [dbo].[TaxDescription]
------------------------------------------------------
select [TABLE_NAME],[COLUMN_NAME],[DATA_TYPE],c.CHARACTER_MAXIMUM_LENGTH,
		c.*
		
from [INFORMATION_SCHEMA].[COLUMNS] c

where [TABLE_NAME] = 'TaxDescription' /* Of course, you need to replace 'Emp' with your own table.*/

 

select count(*) as [Number of Columns]

from [INFORMATION_SCHEMA].[COLUMNS]

where [TABLE_NAME] = 'AppraisalAccount' /* Of course, you need to replace 'Emp' with your own table.*/