DECLARE @time0 time(0) = '0:00:00'; 
DECLARE @time6 time(0) = '6:00:00'; 
DECLARE @time12 time(0) = '12:00:00'; 
DECLARE @time18 time(0) = '18:00:00';
DECLARE @time24 time(0) = '23:59:59';
SELECT 
HOURSPENT,
CONCAT(SUM(CAST(REPLACE(MN,'%','') AS float)/100)/COUNT(1)*100,'%') AS T_MN,
CONCAT(SUM(CAST(REPLACE(AF,'%','') AS float)/100)/COUNT(1)*100,'%') AS T_AF,
CONCAT(SUM(CAST(REPLACE(PT,'%','') AS float)/100)/COUNT(1)*100,'%') AS T_PT,
CONCAT(SUM(CAST(REPLACE(LN,'%','') AS float)/100)/COUNT(1)*100,'%') AS T_LN
FROM
(select
cast(RSH_START_TIME as time) as starttime, 
cast(RSH_END_TIME as time) as endtime, 
TIMESPENT, 
(case
when TIMESPENT > 18000 and TIMESPENT < 21600 then '5 - 6 hours'
when TIMESPENT > 21600 and TIMESPENT < 25200 then '6 - 7 hours'
when TIMESPENT > 25200 and TIMESPENT < 28800 then '7 - 8 hours'
when TIMESPENT > 28800 and TIMESPENT < 32400 then '8 - 9 hours'
when TIMESPENT > 32400 and TIMESPENT < 36000 then '9 - 10 hours'
when TIMESPENT > 36000 and TIMESPENT < 39600 then '10 - 11 hours'
when TIMESPENT > 39600 and TIMESPENT < 43200 then '11 - 12 hours'
when TIMESPENT > 43200 and TIMESPENT < 46800 then '12 - 13 hours'
when TIMESPENT > 46800 and TIMESPENT < 50400 then '13 - 14 hours'
when TIMESPENT > 50400 and TIMESPENT < 24000 then '14 - 15 hours'
end) as HOURSPENT,
--DATEDIFF(second, cast(RSH_START_TIME as time), cast(RSH_END_TIME as time)) as ts2,
--DATEDIFF(hour, cast(RSH_START_TIME as time),@time12) as ts3,
--(0 < DATEDIFF(hour, cast(RSH_START_TIME as time),@time) and DATEDIFF(hour, cast(RSH_START_TIME as time),@time) < 6) as boltest
      CONCAT((case
          when
          --        #---------------------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time6,  cast(RSH_START_TIME as time)) < 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time12) < 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 21600
            then 
            cast(DATEDIFF(second, @time6, @time12)as decimal(9,0))/TIMESPENT * 100
          when
          --              #----------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time6,  cast(RSH_START_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time12) > 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) < 21600
            then 
            cast(DATEDIFF(second, cast(RSH_START_TIME as time), cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
          when
          --                 #---------|-----%
      -- |_____________|_______________|
          (0 < DATEDIFF(second, cast(RSH_START_TIME as time),@time12)and DATEDIFF(second, cast(RSH_START_TIME as time),@time12) <21600)
          then
          cast(DATEDIFF(second, cast(RSH_START_TIME as time),@time12)as decimal(9,0))/TIMESPENT * 100
           when
          --#----------|-----%          
      -- |_____________|_______________|
           (0 < DATEDIFF(second, @time6,  cast(RSH_END_TIME as time)) and  DATEDIFF(second, @time6,  cast(RSH_END_TIME as time)) < 21600)
           then
           cast(DATEDIFF(second, @time6, cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
      end),'%') as MN,
	        CONCAT((case
          when
          --        #---------------------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time12,  cast(RSH_START_TIME as time)) < 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time18) < 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 21600
            then 
            cast(DATEDIFF(second, @time12, @time18)as decimal(9,0))/TIMESPENT * 100
          when
          --              #----------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time12,  cast(RSH_START_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time18) > 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) < 21600
            then 
            cast(DATEDIFF(second, cast(RSH_START_TIME as time), cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
          when
          --                 #---------|-----%
      -- |_____________|_______________|
          (0 < DATEDIFF(second, cast(RSH_START_TIME as time),@time18)and DATEDIFF(second, cast(RSH_START_TIME as time),@time18) <21600)
          then
          cast(DATEDIFF(second, cast(RSH_START_TIME as time),@time18)as decimal(9,0))/TIMESPENT * 100
           when
          --#----------|-----%          
      -- |_____________|_______________|
           (0 < DATEDIFF(second, @time12,  cast(RSH_END_TIME as time)) and  DATEDIFF(second, @time12,  cast(RSH_END_TIME as time)) < 21600)
           then
           cast(DATEDIFF(second, @time12, cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
      end),'%') as AF,
	        CONCAT((case
          when
          --        #---------------------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time18,  cast(RSH_START_TIME as time)) < 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time24) < 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 21600
            then 
            cast(DATEDIFF(second, @time18, @time24)as decimal(9,0))/TIMESPENT * 100
          when
          --              #----------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time18,  cast(RSH_START_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time24) > 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) < 21600
            then 
            cast(DATEDIFF(second, cast(RSH_START_TIME as time), cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
          when
          --                 #---------|-----%
      -- |_____________|_______________|
          (0 < DATEDIFF(second, cast(RSH_START_TIME as time),@time24)and DATEDIFF(second, cast(RSH_START_TIME as time),@time24) <21600)
          then
          cast(DATEDIFF(second, cast(RSH_START_TIME as time),@time24)as decimal(9,0))/TIMESPENT * 100
           when
          --#----------|-----%          
      -- |_____________|_______________|
           (0 < DATEDIFF(second, @time18,  cast(RSH_END_TIME as time)) and  DATEDIFF(second, @time18,  cast(RSH_END_TIME as time)) < 21600)
           then
           cast(DATEDIFF(second, @time18, cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
      end),'%') as PT,
	        CONCAT((case
          when
          --        #---------------------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time0,  cast(RSH_START_TIME as time)) < 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time6) < 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 21600
            then 
            cast(DATEDIFF(second, @time0, @time6)as decimal(9,0))/TIMESPENT * 100
          when
          --              #----------%          
      -- |_____________|_______________|
            DATEDIFF(second, @time0,  cast(RSH_START_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_END_TIME as time),@time6) > 0 
            and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) > 0 and DATEDIFF(second, cast(RSH_START_TIME as time),  cast(RSH_END_TIME as time)) < 21600
            then 
            cast(DATEDIFF(second, cast(RSH_START_TIME as time), cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
          when
          --                 #---------|-----%
      -- |_____________|_______________|
          (0 < DATEDIFF(second, cast(RSH_START_TIME as time),@time6)and DATEDIFF(second, cast(RSH_START_TIME as time),@time6) <21600)
          then
          cast(DATEDIFF(second, cast(RSH_START_TIME as time),@time6)as decimal(9,0))/TIMESPENT * 100
           when
          --#----------|-----%          
      -- |_____________|_______________|
           (0 < DATEDIFF(second, @time0,  cast(RSH_END_TIME as time)) and  DATEDIFF(second, @time0,  cast(RSH_END_TIME as time)) < 21600)
           then
           cast(DATEDIFF(second, @time0, cast(RSH_END_TIME as time))as decimal(9,0))/TIMESPENT * 100
      end),'%') as LN
      
--      CONCAT(MN , '%') AS MORNING,
--      CONCAT(AF , '%') AS AFTERNOON,
--      CONCAT(PT , '%') AS PRIMETIME,
--      CONCAT(LN , '%') AS LATENIGHT
from dbo.IMPORTSTREAM_SUMMARY_NEW_ADHOC
where TIMESPENT > 18000
) A GROUP BY HOURSPENT ORDER BY HOURSPENT ASC