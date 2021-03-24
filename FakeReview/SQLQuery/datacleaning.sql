
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'reviewer'


declare @col varchar(50) = 'funnyCount'
declare @table varchar(50) = 'review'
declare @sql varchar(250) = ''
--set @sql ='
--select distinct '+ @col +'
--from '+ @table +' where '+ @col +' is not null'
--exec(@sql)

set @sql ='
select count(*)
from '+ @table 
+' where '+ @col +' is null'-- or '+ @col+' = '''''
exec(@sql)
print(@sql)

set @table = 'review'

set @sql ='
select count(*)
from '+ @table 
+' where '+ @col +' is null'-- or '+ @col+' = '''''
exec(@sql)
print(@sql)

select count(*)
from reviewer

select (791279 + 688329)
------------------------------------------------------

select SUBSTRING(categories, 0, 12)
from restaurant
where SUBSTRING(categories, 0, 12)

select categories

from hotel
where friendCount=' '

Casual,Dressy,Formal (Jacket Required)

Beer & Wine Only, Full Bar, No

Average, Loud, Quiet, Very Loud,
Classy, Trendy, Upscale, Casual, Intimate, Touristy, Upmarket, Hipdter, Trendy, Divey, Romantic