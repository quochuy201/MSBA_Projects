alter function getDistancefromlatlonInkm( @lat1 as float,
					@lon1 as float,
					@lat2 as float,
					@lon2 as float)
returns float as
begin
	declare @R as int = 6371 --- Earth radius in KM
	declare @dlat as float
	declare @dlon as float
	declare @a as float
	declare @b as float
	declare @c as float
	declare @d as float
	declare @dmile as float
	set @dlat = (@lat2-@lat1)*pi()/180
	set @dlon = (@lon2-@lon1)*pi()/180
	set @a = power(Sin(@dlat/2),2) + cos(@lat1*pi()/180)*cos(@lat2*pi()/180)*power(sin(@dlon/2),2)
	set @c = 2*atn2(sqrt(@a), sqrt(1-@a))
	set @d = @R*@c; -- distance in km
	set @dmile = @d/1.609344

	return @dmile

end;

