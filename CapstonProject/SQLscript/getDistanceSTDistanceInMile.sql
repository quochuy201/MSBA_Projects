--1.	Get distance function
-- using lat and lon between property and crime to calcualate the distance between them. 

USE [19su5510_lehuy]
GO

/****** Object:  UserDefinedFunction [dbo].[getDistanceSTDistanctMile]    Script Date: 8/12/2019 4:00:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[getDistanceSTDistanceMile] (@lat1 as real, 
@lon1 as real, 
@lat2 as real, 
@lon2 as real) 
returns real as 
begin 

declare @d as real 
declare @NWI geography, @EDI geography 
SET @NWI = geography::Point( @lat1,@lon1, 4326) 
SET @EDI = geography::Point( @lat2,@lon2, 4326) 
SELECT @d = @NWI.STDistance(@EDI) / 1609.344 
return @d 
end; 
GO

