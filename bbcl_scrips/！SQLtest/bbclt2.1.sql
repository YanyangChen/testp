SELECT 
COUNT(DISTINCT VIDEOID)
	FROM /* BBCL_TABLE */
  (
select *
from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY
where convert(date, HKDATETIME) = '2017-10-23'
and UA in ('48', '49', '50', '51')) t