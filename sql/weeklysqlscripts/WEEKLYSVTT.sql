select  
RSH_TVB_PRODUCT AS PRODUCT, 
'LIVE AND ARCHIVE' AS CATEGORY, 
RSH_DEVICE_DETAIL AS DEVICE, 
'ALL' AS CITYNAME, 
WEEK_NO_RSH_YYWK AS WEEKNO,
FIRST_DAY_OF_WEEK_RSH AS STARTDATE, --replace
LAST_DAY_OF_WEEK_RSH AS ENDDATE, --replace 
count(distinct VISITOR+UA+VIDEOID+UPID) as SV, 
        count(distinct VISITOR) as USB, 
        sum(TIMESPENT) as DURATION 
from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY,
(select WEEK_NO_RSH_YYWK, FIRST_DAY_OF_WEEK_RSH, LAST_DAY_OF_WEEK_RSH
from dbo.DIM_DATE
where [DATE] = %(end_date)s ) A

where RSH_TVB_PRODUCT = 'BBCL' 
GROUP BY RSH_TVB_PRODUCT, WEEK_NO_RSH_YYWK, RSH_DEVICE_DETAIL,
FIRST_DAY_OF_WEEK_RSH, LAST_DAY_OF_WEEK_RSH
order by DEVICE desc