select 
count (RSH_TVB_PRODUCT_CATEGORY) as total,
sum (
case
when RSH_TVB_PRODUCT_CATEGORY = 'Live' then 1 else 0
end
) as live,
sum (
case
when RSH_TVB_PRODUCT_CATEGORY = 'non-Live' then 1 else 0
end
) as upload,
(case
WHEN COUNTRYNAME = 'China' THEN CONCAT(COUNTRYNAME,'-',CITYNAME) ELSE COUNTRYNAME
end) AS COUNTRYCITY,
--count(distinct VISITOR+UA+VIDEOID+UPID) as SV,
count(distinct VISITOR) as USB
--from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY,
from dbo.V_IMPORTSTREAM_NEW
where HKDATE BETWEEN '2017-11-06' AND '2017-11-12' AND RSH_TVB_PRODUCT = 'BBCL' 
group by (case
WHEN COUNTRYNAME = 'China' THEN CONCAT(COUNTRYNAME,'-',CITYNAME) ELSE COUNTRYNAME
end)
