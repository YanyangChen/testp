select *
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
       from (-- live video list
              select *
              from bbc_cms.bbc_posts
              where BATCH_DATE = %(end_date)s      /* last image date of last week */
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
                              end)) between %(start_date)s  and %(end_date)s ) as video_list
-- aggregate BBCL live streaming performance
left join (select RSH_TVB_PRODUCT,
                    RSH_TVB_PRODUCT_CATEGORY,
                    VIDEOID,
                    count(distinct VISITOR+UA+UPID+VIDEOID) as SV,
                    count(distinct VISITOR) as USB,
                    sum(TIMESPENT) as TIMEPSENT
            from dbo.IMPORTSTREAM_SUMMARY_NEW_7DAY /* last week summary table */
            where RSH_TVB_PRODUCT = 'BBCL'
            and RSH_TVB_PRODUCT_CATEGORY = 'Live'
            group by RSH_TVB_PRODUCT,
                       RSH_TVB_PRODUCT_CATEGORY,
                       VIDEOID) as sv
on video_list.spid = sv.VIDEOID
-- aggregate BBCL live streaming performance in other platforms
left join (select spid,
                    sum(sp_facebook_tvb_total_view_count + sp_facebook_mytv_super_total_view_count + sp_facebook_see_see_tvb_total_view_count + sp_facebook_tvb_anywhere_total_view_count + sp_facebook_tvb_usa_total_view_count) as facebook_total_view,
                    sum(sp_facebook_tvb_live_count + sp_facebook_mytv_super_live_count + sp_facebook_see_see_tvb_live_count + sp_facebook_tvb_anywhere_live_count + sp_facebook_tvb_usa_live_count) as facebook_live_view,
                    sum(sp_facebook_tvb_total_view_count + sp_facebook_mytv_super_total_view_count + sp_facebook_see_see_tvb_total_view_count + sp_facebook_tvb_anywhere_total_view_count + sp_facebook_tvb_usa_total_view_count)
                     - sum(sp_facebook_tvb_live_count + sp_facebook_mytv_super_live_count + sp_facebook_see_see_tvb_live_count + sp_facebook_tvb_anywhere_live_count + sp_facebook_tvb_usa_live_count) as facebook_archive_view,
                    sum(sp_youtube_tvb_total_view_count + sp_youtube_mytv_super_total_view_count + sp_youtube_see_see_tvb_total_view_count + sp_youtube_tvb_anywhere_total_view_count + sp_youtube_tvb_usa_total_view_count + sp_youtube_bbc_total_view_count) as youtube_total_view,
                    sum(sp_youtube_tvb_live_count + sp_youtube_mytv_super_live_count + sp_youtube_see_see_tvb_live_count + sp_youtube_tvb_anywhere_live_count + sp_youtube_tvb_usa_live_count + sp_youtube_bbc_live_count) as youtube_live_view,
                    sum(sp_youtube_tvb_total_view_count + sp_youtube_mytv_super_total_view_count + sp_youtube_see_see_tvb_total_view_count + sp_youtube_tvb_anywhere_total_view_count + sp_youtube_tvb_usa_total_view_count + sp_youtube_bbc_total_view_count)
                     - sum(sp_youtube_tvb_live_count + sp_youtube_mytv_super_live_count + sp_youtube_see_see_tvb_live_count + sp_youtube_tvb_anywhere_live_count + sp_youtube_tvb_usa_live_count + sp_youtube_bbc_live_count) as youtube_archive_view,
                    sum(sp_instagram_tvb_total_view_count + sp_instagram_see_see_tvb_total_view_count) as instagram_total_view,
                    sum(sp_instagram_tvb_live_count + sp_instagram_see_see_tvb_live_count) as instagram_live_view,
                    sum(sp_instagram_tvb_total_view_count + sp_instagram_see_see_tvb_total_view_count)
                     - sum(sp_instagram_tvb_live_count + sp_instagram_see_see_tvb_live_count) as instagram_archive_view,
                    sum(sp_twitter_tvb_total_view_count) as twitter_total_view,
                    sum(sp_twitter_tvb_live_count) as twitter_live_view,
                    sum(sp_twitter_tvb_total_view_count)
                     - sum(sp_twitter_tvb_live_count) as twitter_archive_view,
                    sum(sp_sina_weibo_total_view_count) as sina_weibo_total_view,
                    sum(sp_sina_weibo_live_count) as sina_weibo_live_view,
                    sum(sp_sina_weibo_total_view_count)
                     - sum(sp_sina_weibo_live_count) as sina_weibo_archive_view,
                    sum(sp_tencent_weibo_total_view_count) as tencent_weibo_total_view,
                    sum(sp_tencent_weibo_live_count) as tencent_weibo_live_view,
                    sum(sp_tencent_weibo_total_view_count)
                     - sum(sp_tencent_weibo_live_count) as tencent_weibo_archive_view,
                    sum(sp_youku_total_view_count) as youku_total_view,
                    sum(sp_youku_live_count) as youku_live_view,
                    sum(sp_youku_total_view_count)
                     - sum(sp_youku_live_count) as youku_archive_view,
                    sum(sp_wechat_total_view_count) as wechat_total_view,
                    sum(sp_wechat_live_count) as wechat_live_view,
                    sum(sp_wechat_total_view_count)
                     - sum(sp_wechat_live_count) as wechat_archive_view,
                    sum(sp_doupan_total_view_count) as doupan_total_view,
                    sum(sp_doupan_live_count) as doupan_live_view,
                    sum(sp_doupan_total_view_count)
                     - sum(sp_doupan_live_count) as doupan_archive_view,
                    sum(sp_others_live_count) as others_total_view,
                    sum(sp_others_total_view_count) as others_live_view,
                    sum(sp_others_live_count)
                     - sum(sp_others_total_view_count) as others_archive_view
            from bbc_cms.bbc_posts_daily_change
            where -- filter out the video performance daily change in last week
                  BATCH_DATE between %(start_date)s  and %(end_date)s
            group by spid) as sv_others
on video_list.spid = sv_others.spid

