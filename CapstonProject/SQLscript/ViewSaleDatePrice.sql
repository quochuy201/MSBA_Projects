create view SaleDatePrice
as

SELECT ParcelNumber,
[1_Dates],[1_Prices],
[2_Dates],[2_Prices],
[3_Dates],[3_Prices] 
from (
	select ParcelNumber,  cast(cast(SaleOrder as varchar) +'_'+col as varchar) as cols, value
	from (
		select top 100 Row_number()
				 OVER (
				   partition BY (Sale.ParcelNumber)
				   ORDER BY Sale.SaleDate Desc) SaleOrder, ParcelNumber, cast(SaleDate as varchar) as Dates, cast(SalePrice as varchar) as Prices
		from Sale
	--group by ParcelNumber, SaleDate
	) t
	unpivot ( value FOR col in ([Dates],[Prices])) unpiv
) tp
pivot ( max(value) FOR cols in ([1_Dates],[1_Prices],[2_Dates],[2_Prices],[3_Dates],[3_Prices])) piv 


