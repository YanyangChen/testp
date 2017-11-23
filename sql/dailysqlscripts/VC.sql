 select sp_type, 
        count(spid) as video_count 
from (select a.spid, 
              a.sp_type, 
             a.sp_content, 
             a.sauid, 
              d.sau_nickname, 
             dateadd(hour, 8, a.sp_created_at) as video_last_create_datetime, 
              b.video_upload_datetime, 
              c.video_live_start_datetime, 
              c.video_live_end_datetime, 
              c.video_duration 
       from (select * 
              from bbc_cms.bbc_posts 
              where BATCH_DATE = %(date)s) as a 
              left join (select spid, 
                                  min(dateadd(hour, 8, svu_created_at)) as video_upload_datetime 
                          from bbc_cms.bbc_video_uploads 
                          group by spid) as b 
              on a.spid = b.spid 
              left join (select spid, 
                                  min(dateadd(hour, 8, slrh_started_at)) as video_live_start_datetime, 
                                  max(dateadd(hour, 8, slrh_ended_at)) as video_live_end_datetime, 
                                  max(dateadd(hour, 8, slrh_ended_at)) - min(dateadd(hour, 8, slrh_started_at)) as video_duration 
                          from bbc_cms.bbc_live_rooms_history 
                          group by spid) as c 
              on a.spid = c.spid 
              left join (select * 
                          from bbc_cms.bbc_app_users 
                          where sau_user_type = 'performer') as d 
              on a.sauid = d.sauid 
       where convert(date, (case when c.video_live_start_datetime is not null 
                                     then c.video_live_start_datetime 
                                     when b.video_upload_datetime is not null 
                                     then b.video_upload_datetime 
                                     else dateadd(hour, 8, a.sp_created_at) end)) = %(date)s) as z group by sp_type 