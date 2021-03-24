--- Data preparation 2020-01-21
--- Huy Le
--- Taks:
---		+ Clean data: remove those review for business which are not restaurant or hotel
---		+ Join review and reviewer for fature generation
---		+ Generate non-text features





---- check whether there are reviews for others type of business rather than restaurant
---- we have 1295617 unique reviews from 2 table review and ht_review by reviewID and restraurantID
---- select distinct * return 1306056 records
---- select distinct reviewID return 1295329 records
---- select distinct reviewID, restaurantID return 1295696 records
---- select distinct reviewID, reviewerID, restaurantID return 1295617 records
---- union return 1306056 record when union all return 1479608

--- ***Note***: I think remove duplicate review by both ReviewID, ReviewerID and restaurantID is the most correct way

--- ***Remove Duplicate** 
--- there are 183991 duplicate rows by reviewID, reviewerID, restaurantID
with CTE (RowID, reviewID, reviewerID, restaurantID)
as (
SELECT ROW_NUMBER()  Over (Partition by  reviewID, reviewerID, restaurantID 
							order by (select 0)) as RowID, reviewID, reviewerID, restaurantID 
FROM review 
)
--Delete from CTE
--where RowID >1

--- ***remove null and '' reviewID
--- 3 rows were removed
--delete
--from review
--where isnull(reviewID,'')='' or 
--		isnull(reviewerID,'')='' or
--		isnull(restaurantID,'')=''
select count(*) -- 1295614
from review
---------------------------------------
--- insert business from hotel table to restaurant table
--- because hotel's columns are less than restaurant's column
--insert into restaurant(restaurantID,
--						name,
--						location,
--						reviewCount,
--						rating,
--						categories,
--						address,
--						AcceptsCreditCards,
--						PriceRange,
--						WiFi,
--						webSite,
--						phoneNumber,
--						filReviewCount)
--select hotelID,
--		name,
--		location,
--		reviewCount,
--		rating,
--		categories,
--		address,
--		AcceptsCreditCards,
--		PriceRange,
--		WiFi,
--		webSite,
--		phoneNumber,
--		filReviewCount
--from hotel

--- number of rows in restaurant table: 242652

select count(*)
from restaurant

--- number of rows in hotel table: 283086
select count(*)
from hotel

---- number of rows are acctually restaurant or hotels based on categories: 269870
select count(*)
from restaurant
where CHARINDEX('Restaurant', categories) >0 or CHARINDEX('Hotel', categories) >0

select *
from restaurant
where lower(categories) like '%restaurant%' or lower(categories) like '%hotel%'

---- remove duplicate and Id null rows
---- check how many distinct row retaurant table have: 516905
select distinct *
from restaurant
----- 
select *
from restaurant
where isnull(restaurantID,'') ='' 

---- delete duplicated rows : 149285 rows affected
with CTE (RowID, restaurantID)
as (
SELECT ROW_NUMBER()  Over (Partition by  restaurantID 
							order by (select 0)) as RowID, restaurantID 
FROM restaurant 
)
--Delete from CTE
--where RowID >1
--
--
--
-----------------------------------------------------------------------
--- I probaly only take those businesses which are restaurant or hotel in
--- my research, and i might only use some specific columns. thus i will create
--- a view to store all businesse entity with selected columns:
--- columns: restaurantID, name, reviewcount, rating, categories, PriceRange,filReviewCount
select * from filBusiness;

-------------------------------------------------------------------------
--- ***** clean reviewer: 22064 reviewers
select * 
from reviewer

--- check duplicate: 21276 distinct rows
select distinct reviewerID
from reviewer;

--- let see who are duplicated: 788
with CTE (RowID , reviewerID)
as (
SELECT ROW_NUMBER() Over (Partition by  reviewerID 
							order by (select 0)) as RowID, reviewerID
							FROM dbo.reviewer )
select * from CTE 
--Delete from CTE
--where RowID >1
------------------------------------------------------------------------
---**** create final data table, and aggregate features ****
--- JOIN review <- reviewer <- business

select r.reviewID, r.reviewerID, r.restaurantID as businessID,
		r.reviewContent,
		r.rating as reviewRating,
		r.usefulCount as reUsefulCount,
		r.coolCount as reCoolCount,
		r.funnyCount as reFunnycount,
		re.yelpJoinDate, 
		re.friendCount, re.fanCount, re.tipCount,
		re.reviewCount, re.firstCount, re.usefulCount, re.coolCount, re.complimentCount, re.funnyCount,
		b.rating as BusRating,
		b.categories as BusCateg,
		b.PriceRange as PriceRange,
		b.filReviewCount  as filReviewCount,
		DATEDIFF(day, r.date, re.yelpJoinDate)/30 as MonMembership,
		r.flagged	
from review r left join
		reviewer re on r.reviewerID= re.reviewerID left join
		filBusiness b on r.restaurantID = b.businessID
where year(r.date) between 2010 and 2012
---- we have 1295614 rows = num of reviews.
---- the dataset is too big and too old to me, so i only chose those review from 2010 to 2012: 773,332
---- 
---- new features:
---- Membership length: the number of months that a reviewer has been a yelp member at the time they write the reivew
----				 = DATEDIFF(day, datereview,joinDate)/30
---- averageRating : average rating that reviewer has posted
---- Max reivew/day : the maximum number of review was written in one day
---- reviewlength : the totle number of word, if will generate in python after i prepocess review content
---- firstreivew : if review was write in the earliest day, it will count as frist review
---- number of First review: number of time reviewer write at the earliest date.


--- first review indicated by rank of row order by review date.
select distinct rank() Over (Partition by  r.restaurantID
							order by (r.date)) as RowID, reviewID, restaurantID, reviewerID, date
FROM dbo.review r

-- max numer of writen review within a day
select a.reviewerID, max(reCount) as maxReCount, avg(reCount) as avgReCount
from (
select r.reviewerID, count(r.reviewID) as reCount, date
from review r
group by r.reviewerID , date) a
group by reviewerID

----- average posted rating by reviewer
select distinct a.reviewerID
from (
select r.reviewerID, cast(AVG(r.rating) as float) as avgPostedRating,
		cast(avg(len(r.reviewContent))as float) as avgReviewLen
from review r
group by r.reviewerID) a
