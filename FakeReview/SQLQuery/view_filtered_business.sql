USE [YelpResData]
GO

/****** Object:  View [dbo].[filBusiness]    Script Date: 3/16/2020 2:46:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [dbo].[filBusiness]
as

select restaurantID as businessID,
		name,
		reviewCount, 
		rating, 
		case 			
			when lower(categories) like '%restaurant%' and lower(categories) like '%hotel%' then 'Restaurants and Hotels'
			when lower(categories) like '%restaurant%'then 'Restaurants'
			when lower(categories) like '%hotel%' then 'Hotels'
		else 'Others'
		end as categories, 
		len(trim(PriceRange)) as PriceRange,
		filReviewCount
from restaurant r
where lower(categories) like '%restaurant%' or lower(categories) like '%hotel%'
GO


