select sum(sp_facebook_tvb_total_view_count + sp_facebook_mytv_super_total_view_count + sp_facebook_see_see_tvb_total_view_count + sp_facebook_tvb_anywhere_total_view_count + sp_facebook_tvb_usa_total_view_count) as facebook_total_view,
        sum(sp_youtube_tvb_total_view_count + sp_youtube_mytv_super_total_view_count + sp_youtube_see_see_tvb_total_view_count + sp_youtube_tvb_anywhere_total_view_count + sp_youtube_tvb_usa_total_view_count + sp_youtube_bbc_total_view_count) as youtube_total_view,
        sum(sp_instagram_tvb_total_view_count + sp_instagram_see_see_tvb_total_view_count) as instagram_total_view,
        sum(sp_twitter_tvb_total_view_count) as twitter_total_view,
        sum(sp_sina_weibo_total_view_count) as sina_weibo_total_view,
        sum(sp_tencent_weibo_total_view_count) as tencent_weibo_total_view,
        sum(sp_youku_total_view_count) as youku_total_view,
        sum(sp_wechat_total_view_count) as wechat_total_view,
        sum(sp_doupan_total_view_count) as doupan_total_view,
        sum(sp_others_live_count) as others_total_view
from bbc_cms.bbc_posts_daily_change
where BATCH_DATE between %(start_date)s and %(end_date)s

union all

select sum(sp_facebook_tvb_live_count + sp_facebook_mytv_super_live_count + sp_facebook_see_see_tvb_live_count + sp_facebook_tvb_anywhere_live_count + sp_facebook_tvb_usa_live_count) as facebook_live_view,
        sum(sp_youtube_tvb_live_count + sp_youtube_mytv_super_live_count + sp_youtube_see_see_tvb_live_count + sp_youtube_tvb_anywhere_live_count + sp_youtube_tvb_usa_live_count + sp_youtube_bbc_live_count) as youtube_live_view,
        sum(sp_instagram_tvb_live_count + sp_instagram_see_see_tvb_live_count) as instagram_live_view,
        sum(sp_twitter_tvb_live_count) as twitter_live_view,
        sum(sp_sina_weibo_live_count) as sina_weibo_live_view,
        sum(sp_tencent_weibo_live_count) as tencent_weibo_live_view,
        sum(sp_youku_live_count) as youku_live_view,
        sum(sp_wechat_live_count) as wechat_live_view,
        sum(sp_doupan_live_count) as doupan_live_view,
        sum(sp_others_total_view_count) as others_live_view
from bbc_cms.bbc_posts_daily_change
where BATCH_DATE between %(start_date)s and %(end_date)s

union all

select sum(sp_facebook_tvb_total_view_count + sp_facebook_mytv_super_total_view_count + sp_facebook_see_see_tvb_total_view_count + sp_facebook_tvb_anywhere_total_view_count + sp_facebook_tvb_usa_total_view_count)
         - sum(sp_facebook_tvb_live_count + sp_facebook_mytv_super_live_count + sp_facebook_see_see_tvb_live_count + sp_facebook_tvb_anywhere_live_count + sp_facebook_tvb_usa_live_count) as facebook_archive_view,
        sum(sp_youtube_tvb_total_view_count + sp_youtube_mytv_super_total_view_count + sp_youtube_see_see_tvb_total_view_count + sp_youtube_tvb_anywhere_total_view_count + sp_youtube_tvb_usa_total_view_count + sp_youtube_bbc_total_view_count)
         - sum(sp_youtube_tvb_live_count + sp_youtube_mytv_super_live_count + sp_youtube_see_see_tvb_live_count + sp_youtube_tvb_anywhere_live_count + sp_youtube_tvb_usa_live_count + sp_youtube_bbc_live_count) as youtube_archive_view,
        sum(sp_instagram_tvb_total_view_count + sp_instagram_see_see_tvb_total_view_count) - sum(sp_instagram_tvb_live_count + sp_instagram_see_see_tvb_live_count) as instagram_archive_view,
        sum(sp_twitter_tvb_total_view_count) - sum(sp_twitter_tvb_live_count) as twitter_archive_view,
        sum(sp_sina_weibo_total_view_count) - sum(sp_sina_weibo_live_count) as sina_weibo_archive_view,
        sum(sp_tencent_weibo_total_view_count) - sum(sp_tencent_weibo_live_count) as tencent_weibo_archive_view,
        sum(sp_youku_total_view_count) - sum(sp_youku_live_count) as youku_archive_view,
        sum(sp_wechat_total_view_count) - sum(sp_wechat_live_count) as wechat_archive_view,
        sum(sp_doupan_total_view_count) - sum(sp_doupan_live_count) as doupan_archive_view,
        sum(sp_others_live_count) - sum(sp_others_total_view_count) as others_archive_view
from bbc_cms.bbc_posts_daily_change
where BATCH_DATE between  %(start_date)s and %(end_date)s

