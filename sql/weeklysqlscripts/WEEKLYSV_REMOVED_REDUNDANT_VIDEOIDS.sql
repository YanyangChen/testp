select * from
(select 
VIDEOID,
RSH_TVB_PRODUCT AS PRODUCT, 
RSH_TVB_PRODUCT_CATEGORY AS CATEGORY,
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
where [DATE] = '2017-11-12' ) A

where RSH_TVB_PRODUCT = 'BBCL' and RSH_TVB_PRODUCT_CATEGORY = 'live'
GROUP BY RSH_TVB_PRODUCT, RSH_TVB_PRODUCT_CATEGORY,WEEK_NO_RSH_YYWK, VIDEOID,
FIRST_DAY_OF_WEEK_RSH, LAST_DAY_OF_WEEK_RSH) x
-- USING JOIN TO REMOVE UNRELATED VEDIOIDS
 join (select  a.spid,
              a.sp_type,
              a.sp_content,
              a.sauid,
              d.sau_nickname,
              dateadd(hour, 8, a.sp_created_at) as video_last_create_datetime,
              b.video_upload_datetime,
              c.video_live_start_datetime,
              c.video_live_end_datetime,
              c.video_duration
       from (-- live video list
              select *
              from bbc_cms.bbc_posts
              where BATCH_DATE = '2017-11-12'     /* last image date of last week */
              and   sp_type = 'live') as a
              -- video start & end time of "video upload" videos
              left join (select spid,
                                  min(dateadd(hour, 8, svu_created_at)) as video_upload_datetime
                          from bbc_cms.bbc_video_uploads
                          group by spid) as b
              on a.spid = b.spid
              -- video start & end time of "live" videos
              left join (select spid,
                                  min(dateadd(hour, 8, slrh_started_at)) as video_live_start_datetime,
                                  max(dateadd(hour, 8, slrh_ended_at)) as video_live_end_datetime,
                                  datediff(second, min(dateadd(hour, 8, slrh_started_at)), max(dateadd(hour, 8, slrh_ended_at))) as video_duration
                          from bbc_cms.bbc_live_rooms_history
                          group by spid) as c
              on a.spid = c.spid
              -- video performer list
              left join (select *
                          from bbc_cms.bbc_app_users
                          where sau_user_type = 'performer') as d
              on a.sauid = d.sauid
       where -- filter out the video telecasted in last week
              convert(date, (case when c.video_live_start_datetime is not null
                                     then c.video_live_start_datetime
                                     when b.video_upload_datetime is not null
                                     then b.video_upload_datetime
                                     else dateadd(hour, 8, a.sp_created_at)
                              end)) between '2017-11-06'  and '2017-11-12' ) as b
                          on x.VIDEOID = b.spid