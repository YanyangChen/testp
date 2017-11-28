SELECT 
DISTINCT
SP_CONTENT as VIDEO_TITLE,
sau_nickname AS VIDEO_OWNER,
H.VIDEO_LIVE_START_DATETIME AS VIDEO_LIVE_START_DATETIME,
H.VIDEO_LIVE_END_DATETIME AS VIDEO_LIVE_END_DATETIME,
U.VIDEO_UPLOAD_DATETIME AS ARCHIVE_UPLOAD_DATETIME,
COUNT(CONCAT(UA, VISITOR, UPID, VIDEOID)) AS TOTAL_SV,
 /*TAKE MUID AS UNIQUE VISITOR*/
COUNT(DISTINCT MUID) AS TOTAL_UNIQUE_STREAM_VIEWS,
SUM(TIMESPENT) AS TTL_TS,
COUNT(L_SV) AS TOTAL_LIVE_SV,
COUNT(DISTINCT L_VISITOR) AS LIVE_UNIQUE_STREAM_VIEWS,
SUM( L_TIMESPENT) AS LIVE_TTL_TS,
COUNT(A_SV) AS TOTAL_ARCHIVE_SV,
COUNT(DISTINCT A_VISITOR) AS ARCHIVE_UNIQUE_STREAM_VIEWS,
SUM( A_TIMESPENT) AS ARCHIVE_TTL_TS,
facebook_total_view, facebook_live_view, facebook_archive_view,
youtube_total_view, youtube_live_view, youtube_archive_view,
instagram_total_view, instagram_live_view, instagram_archive_view,
twitter_total_view, twitter_live_view, twitter_archive_view,
sina_weibo_total_view, sina_weibo_live_view, sina_weibo_archive_view,
tencent_weibo_total_view, tencent_weibo_live_view, tencent_weibo_archive_view
	FROM /* BBCL_TABLE */
	((select S.*, M.*,
  (CASE
  /*TAKE MUID AS UNIQUE VISITOR*/
	WHEN RSH_TVB_PRODUCT_CATEGORY IN ('Live') THEN MUID ELSE NULL /*UA 48 49 stands for live*/
	END) AS L_VISITOR,
  (CASE
	WHEN RSH_TVB_PRODUCT_CATEGORY IN ('Live') THEN CONCAT(UA, VISITOR, UPID, VIDEOID) ELSE NULL/*using concat to make sure a absolute stream view*/
	END) AS L_SV,
	(CASE
	WHEN RSH_TVB_PRODUCT_CATEGORY IN ('Live') THEN TIMESPENT ELSE NULL
	END) AS L_TIMESPENT,
	(CASE
   /*TAKE MUID AS UNIQUE VISITOR*/
	WHEN RSH_TVB_PRODUCT_CATEGORY IN ('non-Live') THEN MUID ELSE NULL /*UA 50 51 stands for upload*/
	END) AS A_VISITOR,
  (CASE
  WHEN RSH_TVB_PRODUCT_CATEGORY IN ('non-Live') THEN CONCAT(UA, VISITOR, UPID, VIDEOID) ELSE NULL
	END) AS A_SV,
	(CASE
	WHEN RSH_TVB_PRODUCT_CATEGORY IN ('non-Live') THEN TIMESPENT ELSE NULL
	END) AS A_TIMESPENT
      from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY S
/* we usually use left join to prevent missing records */

/*left join bbc_posts table to get video type(sp_type) and content(sp_content) */
      left join (select SPID, SP_TYPE, SP_CONTENT
            from bbc_cms.bbc_posts
            where BATCH_DATE = (select max(BATCH_DATE) from bbc_cms.bbc_posts)) M /* get the lastest image of bbc_posts */
      on S.VIDEOID = M.SPID
      where convert(date, HKDATETIME) = '2017-11-02'
      and RSH_TVB_PRODUCT_CATEGORY IN ('Live', 'non-Live')) AS R

/*left join bbc_live_rooms_history table to calculate duration */
LEFT JOIN
(SELECT SPID,
        MIN(DATEADD(HOUR, 8, SLRH_STARTED_AT)) AS VIDEO_LIVE_START_DATETIME,
        MAX(DATEADD(HOUR, 8, SLRH_ENDED_AT)) AS VIDEO_LIVE_END_DATETIME,
        MAX(DATEADD(HOUR, 8, SLRH_ENDED_AT)) - MIN(DATEADD(HOUR, 8, SLRH_STARTED_AT)) AS VIDEO_DURATION
FROM BBC_CMS.BBC_LIVE_ROOMS_HISTORY
GROUP BY SPID
) AS H
ON R.VIDEOID = H.SPID 

LEFT JOIN
(SELECT sauid ,sau_nickname
FROM SC_ETL_NEW.bbc_cms.bbc_app_users) AS N /*get video owner name from app_user table*/
ON R.VIDEO_OWNER = N.SAUID

LEFT JOIN
(SELECT SPID,
        MIN(DATEADD(HOUR, 8, SVU_CREATED_AT)) AS VIDEO_UPLOAD_DATETIME
FROM BBC_CMS.BBC_VIDEO_UPLOADS
GROUP BY SPID) AS U
ON R.VIDEOID = U.SPID 

LEFT JOIN
(
select  SPID,
        sum(sp_facebook_tvb_total_view_count + sp_facebook_mytv_super_total_view_count + sp_facebook_see_see_tvb_total_view_count + sp_facebook_tvb_anywhere_total_view_count + sp_facebook_tvb_usa_total_view_count) as facebook_total_view,
        sum(sp_facebook_tvb_live_count + sp_facebook_mytv_super_live_count + sp_facebook_see_see_tvb_live_count + sp_facebook_tvb_anywhere_live_count + sp_facebook_tvb_usa_live_count) as facebook_live_view,
        sum(sp_facebook_tvb_total_view_count + sp_facebook_mytv_super_total_view_count + sp_facebook_see_see_tvb_total_view_count + sp_facebook_tvb_anywhere_total_view_count + sp_facebook_tvb_usa_total_view_count) -
        sum(sp_facebook_tvb_live_count + sp_facebook_mytv_super_live_count + sp_facebook_see_see_tvb_live_count + sp_facebook_tvb_anywhere_live_count + sp_facebook_tvb_usa_live_count) as facebook_archive_view,
        sum(sp_youtube_tvb_total_view_count + sp_youtube_mytv_super_total_view_count + sp_youtube_see_see_tvb_total_view_count + sp_youtube_tvb_anywhere_total_view_count + sp_youtube_tvb_usa_total_view_count + sp_youtube_bbc_total_view_count) as youtube_total_view,
        sum(sp_youtube_tvb_live_count + sp_youtube_mytv_super_live_count + sp_youtube_see_see_tvb_live_count + sp_youtube_tvb_anywhere_live_count + sp_youtube_tvb_usa_live_count + sp_youtube_bbc_live_count) as youtube_live_view,
        sum(sp_youtube_tvb_total_view_count + sp_youtube_mytv_super_total_view_count + sp_youtube_see_see_tvb_total_view_count + sp_youtube_tvb_anywhere_total_view_count + sp_youtube_tvb_usa_total_view_count + sp_youtube_bbc_total_view_count) -
        sum(sp_youtube_tvb_live_count + sp_youtube_mytv_super_live_count + sp_youtube_see_see_tvb_live_count + sp_youtube_tvb_anywhere_live_count + sp_youtube_tvb_usa_live_count + sp_youtube_bbc_live_count) as youtube_archive_view,
        sum(sp_instagram_tvb_total_view_count + sp_instagram_see_see_tvb_total_view_count) as instagram_total_view,
        sum(sp_instagram_tvb_live_count + sp_instagram_see_see_tvb_live_count) as instagram_live_view,
        sum(sp_instagram_tvb_total_view_count + sp_instagram_see_see_tvb_total_view_count) - sum(sp_instagram_tvb_live_count + sp_instagram_see_see_tvb_live_count) as instagram_archive_view,
        sum(sp_twitter_tvb_total_view_count) as twitter_total_view,
        sum(sp_twitter_tvb_live_count) as twitter_live_view,
        sum(sp_twitter_tvb_total_view_count) - sum(sp_twitter_tvb_live_count) as twitter_archive_view,
        sum(sp_sina_weibo_total_view_count) as sina_weibo_total_view,
        sum(sp_sina_weibo_live_count) as sina_weibo_live_view,
        sum(sp_sina_weibo_total_view_count) - sum(sp_sina_weibo_live_count) as sina_weibo_archive_view,
        sum(sp_tencent_weibo_total_view_count) as tencent_weibo_total_view,
        sum(sp_tencent_weibo_live_count) as tencent_weibo_live_view,
        sum(sp_tencent_weibo_total_view_count) - sum(sp_tencent_weibo_live_count) as tencent_weibo_archive_view,
        sum(sp_youku_total_view_count) as youku_total_view,
        sum(sp_youku_live_count) as youku_live_view,
        sum(sp_youku_total_view_count) - sum(sp_youku_live_count) as youku_archive_view,
        sum(sp_wechat_total_view_count) as wechat_total_view,
        sum(sp_wechat_live_count) as wechat_live_view,
        sum(sp_wechat_total_view_count) - sum(sp_wechat_live_count) as wechat_archive_view,
        sum(sp_doupan_total_view_count) as doupan_total_view,
        sum(sp_doupan_live_count) as doupan_live_view,
        sum(sp_doupan_total_view_count) - sum(sp_doupan_live_count) as doupan_archive_view,
        sum(sp_others_live_count) as others_total_view,
        sum(sp_others_total_view_count) as others_live_view,
        sum(sp_others_live_count) - sum(sp_others_total_view_count) as others_archive_view
from bbc_cms.bbc_posts_daily_change
where BATCH_DATE = '2017-11-02'
GROUP BY SPID
) AS P
ON R.VIDEOID = P.SPID 

)
GROUP BY SP_CONTENT, sau_nickname, H.VIDEO_LIVE_START_DATETIME, H.VIDEO_LIVE_END_DATETIME, U.VIDEO_UPLOAD_DATETIME,
facebook_total_view, facebook_live_view, facebook_archive_view,
youtube_total_view, youtube_live_view, youtube_archive_view,
instagram_total_view, instagram_live_view, instagram_archive_view,
twitter_total_view, twitter_live_view, twitter_archive_view,
sina_weibo_total_view, sina_weibo_live_view, sina_weibo_archive_view,
tencent_weibo_total_view, tencent_weibo_live_view, tencent_weibo_archive_view
