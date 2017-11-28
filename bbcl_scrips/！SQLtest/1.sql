SELECT  '01)  < 20 secs' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG
FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

				 DISTINCT VISITOR,
				 convert(date, HKDATETIME) AS HKDATE,
				 UPID,
				 VIDEOID,
				 UA,
				 RSH_DEVICE,
				 timespent,
				 (case when timespent <=   20 then '01)  < 20 secs'
					   
				  end) as FREQ_DIST_NAME
--          COUNT(DISTINCT DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_ADHOC
) 