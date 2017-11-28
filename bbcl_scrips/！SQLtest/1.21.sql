DECLARE @time0 time(0) = '0:00:00'; 
DECLARE @time6 time(0) = '6:00:00'; 
DECLARE @time12 time(0) = '12:00:00'; 
DECLARE @time18 time(0) = '18:00:00';
DECLARE @time24 time(0) = '23:59:59';
select
cast(RSH_START_TIME as time) as starttime, 
cast(RSH_END_TIME as time) as endtime, TIMESPENT, 
DATEDIFF(second, cast(RSH_START_TIME as time), cast(RSH_END_TIME as time)) as ts2,
DATEDIFF(hour, cast(RSH_START_TIME as time),@time12) as ts3,
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
order by TIMESPENT asc