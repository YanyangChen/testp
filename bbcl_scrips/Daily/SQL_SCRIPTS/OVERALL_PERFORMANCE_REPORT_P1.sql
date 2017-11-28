--SELECT 
--'2017-11-02' AS DATE,
--COUNT(CONCAT(P_UA, P_VISITOR)) AS PV,
--
--COUNT(DISTINCT P_MUID) AS UNIQUE_VISITORS,
--
--COUNT(CONCAT(S_UA, S_VISITOR, S_UPID, S_VIDEOID)) AS STREAM_VIEWS,
--
--COUNT(DISTINCT S_MUID) AS UNIQUE_STREAM_VISITOR,
--SUM(S_TIMESPENT) AS TOTAL_TS
--	FROM /* BBCL_TABLE */
--  (select t1.*, t2.*
--  from
--  
--(select UA AS S_UA, VISITOR AS S_VISITOR, UPID AS S_UPID, VIDEOID AS S_VIDEOID, MUID AS S_MUID, 
--TIMESPENT AS S_TIMESPENT
--from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY
--where convert(date, HKDATETIME) = '2017-11-02'
--and UA in ('48', '49', '50', '51')) t1,
--(
--select UA as P_UA, VISITOR as P_VISITOR, MUID as P_MUID
--from SC_ETL_NEW.dbo.IMPORTWEB
--where HKDATE = '2017-11-02'
--and UA in ('84', '85')) t2) T


/*
PV       UB
1047681  28447
*/
select 
RSH_TVB_PRODUCT AS PRODUCT,
'TOTAL' AS CATEGORY,
RSH_DEVICE_DETAIL AS DEVICE,
'ALL' AS CITYNAME,
HKDATE,
count(1) as PV,
        count(distinct VISITOR) as UB
from SC_ETL_NEW.dbo.V_IMPORTWEB
where HKDATE = '2017-11-02'
and RSH_TVB_PRODUCT = 'BBCL'
GROUP BY RSH_TVB_PRODUCT, HKDATE, RSH_DEVICE_DETAIL

/* select count(1) as PV,
        count(distinct VISITOR) as UB
from SC_ETL_NEW.dbo.V_IMPORTWEB
where HKDATE = '2017-11-02'
and RSH_TVB_PRODUCT = 'BBCL' */

/*
SV       USB      TIMESPENT
96398    16230    175061945
*/
select 
RSH_TVB_PRODUCT AS PRODUCT,
RSH_TVB_PRODUCT_CATEGORY AS CATEGORY,
RSH_DEVICE_DETAIL AS DEVICE,
'ALL' AS CITYNAME,
'2017-11-03'HKDATE,
count(distinct VISITOR+UA+VIDEOID+UPID) as SV,
        count(distinct VISITOR) as USB,
        sum(TIMESPENT) as DURATION
from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY
where RSH_TVB_PRODUCT = 'BBCL'
GROUP BY RSH_TVB_PRODUCT,RSH_TVB_PRODUCT_CATEGORY, RSH_DEVICE_DETAIL

