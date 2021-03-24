USE [YelpResData]
GO

/****** Object:  View [dbo].[view_final]    Script Date: 2/9/2020 2:06:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter view [dbo].[view_final]
as
select  r.reviewid, r.reviewerid, b.businessid,
		r.reviewcontent,
		r.rating as reviewrating,
		r.usefulcount as reusefulcount,
		r.coolcount as recoolcount,
		r.funnycount as refunnycount,
		r.date as reviewDate,
		re.yelpjoindate, 
		re.friendcount, re.fancount, re.tipcount, --- reviewers information
		re.reviewcount, re.firstcount, re.usefulcount, re.coolcount, re.complimentcount, re.funnycount, --- reviewr information
		b.rating as busrating,
		b.categories as buscateg,
		b.pricerange as pricerange,
		b.filreviewcount  as filreviewcount,
		datediff(day, re.yelpjoindate, r.date)/30 as monmembership,
		t1.rowid as firstreview, --- first review indicated by rank of row order by review date.
		t2.maxrecount as maxReviewDay, --- max number review write/day
		t2.avgrecount as avgReviewDay, --- average review write/day
		t3.avgpostedrating, --- average rating that reviewer posted 
		t3.avgreviewlen, --- average review length
		r.flagged	
from	review r 
		left join
		reviewer re on r.reviewerid= re.reviewerid
		inner join
		filbusiness b on r.restaurantid = b.businessid 
		left join
		(select rank() over (partition by  r.restaurantid
							order by (r.date)) as rowid, reviewid, restaurantid, reviewerid, date
		 from dbo.review r) t1 on r.reviewid = t1.reviewid and r.restaurantID = t1.restaurantID and r.reviewerID = t1.reviewerID
		left join
		(select a.reviewerid, max(recount) as maxrecount, avg(recount) as avgrecount
		from (
				select r.reviewerid, count(r.reviewid) as recount, date
				from review r
		group by r.reviewerid , date) a
		group by reviewerid ) t2 on r.reviewerid = t2.reviewerid 
		left join
		(select r.reviewerid, cast(avg(r.rating) as float) as avgpostedrating,
				cast(avg(len(r.reviewcontent))as float) as avgreviewlen
		from review r
		group by r.reviewerid ) t3 on r.reviewerid = t3.reviewerid
where year(r.date) between 2010 and 2012
--order by r.reviewerid, r.restaurantid, r.reviewid
GO


