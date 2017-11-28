SELECT  '01)  < 20 secs' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent <=   20 then '01)  < 20 secs'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '01)  < 20 secs'

UNION

SELECT  '02)   20.1 secs -   1 min ' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >    20 and timespent <=    60 then '02)   20.1 secs -   1 min '
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '02)   20.1 secs -   1 min '

UNION

SELECT  '03)    1.1 mins -   5 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >    60 and timespent <=   300 then '03)    1.1 mins -   5 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '03)    1.1 mins -   5 mins'

UNION

SELECT  '04)    5.1 mins -  10 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >   300 and timespent <=   600 then '04)    5.1 mins -  10 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '04)    5.1 mins -  10 mins'

UNION

SELECT  '05)   10.1 mins -  15 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >   600 and timespent <=   900 then '05)   10.1 mins -  15 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '05)   10.1 mins -  15 mins'

UNION

SELECT  '06)   15.1 mins -  20 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >   900 and timespent <=  1200 then '06)   15.1 mins -  20 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '06)   15.1 mins -  20 mins'

UNION

SELECT  '07)   20.1 mins -  30 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >  1200 and timespent <=  1800  then '07)   20.1 mins -  30 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '07)   20.1 mins -  30 mins'

UNION

SELECT  '08)   30.1 mins -  60 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >  1800 and timespent <=  3600 then '08)   30.1 mins -  60 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '08)   30.1 mins -  60 mins'

UNION

SELECT  '09)   60.1 mins - 120 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >  3600 and timespent <=  7200 then '09)   60.1 mins - 120 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '09)   60.1 mins - 120 mins'

UNION

SELECT  '10)  120.1 mins - 180 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent >  7200 and timespent <= 10800 then '10)  120.1 mins - 180 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '10)  120.1 mins - 180 mins'

UNION

SELECT  '11)  180.1 mins - 240 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent > 10800 and timespent <= 14400 then '11)  180.1 mins - 240 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '11)  180.1 mins - 240 mins'

UNION

SELECT  '12)  240.1 mins - 300 mins' AS TIME, COUNT(FREQ_DIST_NAME) AS TIME_PERIOD_HEAD_COUNT, 
SUM(CAST(timespent AS BIGINT)) AS TOTAL, SUM(CAST(timespent AS BIGINT))/COUNT(FREQ_DIST_NAME) AS AVG, 
CONCAT(cast(COUNT(swe) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WE, 
CONCAT(cast(COUNT(swd) as decimal(9,0))/ cast((COUNT(swe)+COUNT(swd))as decimal(9,0)) * 100,'%') as WD FROM
(
SELECT   
--convert(date, HKDATETIME) , CONVERT(VARCHAR(10), GETDATE() - 1, 121)

         timespent,
				 (case when timespent > 14400 and timespent <= 18000 then '12)  240.1 mins - 300 mins'
					   
				  end) as FREQ_DIST_NAME,
          (case when
           DATEPART(DW, HKDATETIME) = 1 or DATEPART(DW, HKDATETIME) = 7 then 'weekend'
           
           end) as swe,
          (case when
           DATEPART(DW, HKDATETIME) != 1 and DATEPART(DW, HKDATETIME) != 7 then 'weekday'
           
           end) as swd

--          COUNT(DISTINCT VISITOR)					AS UNIQUE_BROWSERS
		  FROM dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY
) 
A
WHERE A.FREQ_DIST_NAME = '12)  240.1 mins - 300 mins'