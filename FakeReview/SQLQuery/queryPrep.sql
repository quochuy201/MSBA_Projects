
---- highest number of review/day by reviewer
--select d.reviewerID, max(d.reviewcnt) as highestRvcnt
--from (
--	select r.reviewerID, count(r.reviewID) as reviewcnt
--	from review r
--	group by r.reviewerID, r.date) d
--group by d.reviewerID

--

select d.reviewerID, max(d.reviewcnt) as highestPostcnt, max(d.AvgRating) as MaxAvgRating
from (
	select r.reviewerID, count(r.reviewID) as reviewcnt, avg(rating) as AvgRating
	from review r
	group by r.reviewerID, r.date) d
group by d.reviewerID


SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'review'

select min(date), max(date)
from review

select distinct  flagged
from review