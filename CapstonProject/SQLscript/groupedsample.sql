---4.	Groupedsample View
---This view integrate house attribute data from CompiledDataVersion1 view, table LandCrimeDistanceSample2 and table Crime Data. 
--- Then It aggregated and grouped crime by new 5 categories as mentioned in the paper.
USE [19su5510_lehuy]
GO
/****** Object:  View [dbo].[groupedsample]    Script Date: 8/12/2019 4:17:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE view [dbo].[groupedsample]
as
select d.*, e.CrimeCategory, e.NoofCrime
from CompiledDataVersion1 d right join 
(select tb1.ParcelNumber, tb1.CrimeCategory, count( tb1.CrimeCategory) as NoofCrime
from 
(select a.ParcelNumber, c.Public_Nam,case 

            when Public_Nam in ('Arson - Non-residential', 
            'Arson - Residential', 
            'Burglary - Non-residential', 
            'Burglary - Residential','Fraud or Forgery','Motor Vehicle Theft','Possession of Stolen Property', 
            'Robbery - Business','Robbery - Residential','Robbery - Street','Robbery - Other', 
            'Theft - Gas Station Runout','Theft - Mail','Theft - Other','Theft - Vehicle Prowl','Theft -Shoplifing','Trafficking in Stolen Property' 
            ) then 'PropertyCrime' 
            when Public_Nam like '%Drug%' then 'DrugCrime' 
            when Public_Nam = 'Homicide' then 'Homicide' 
            when Public_Nam in ('Assault - Aggravated','Assault - Simple','Intimidation','Telephone Harassment','Vandalism - Non-residential','Vandalism - Residential') then 'PersonalCrime' 
            else 'OtherCrime' 
            end as CrimeCategory 
from LandCrimeDistanceSample2 a left join CrimeData c on a.ObjectID = c.OBJECTID
where a.Distance <=1) tb1
group by tb1.ParcelNumber, tb1.CrimeCategory) e on d.ParcelNumber = e.ParcelNumber
GO

