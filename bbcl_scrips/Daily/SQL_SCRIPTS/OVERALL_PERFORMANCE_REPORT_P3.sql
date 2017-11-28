--select count(1) as LIVE_UPLOAD
--from(
--(select * from
-- SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY) R
--
--
--LEFT JOIN
--(SELECT SPID,
--        MIN(DATEADD(HOUR, 8, SLRH_STARTED_AT)) AS VIDEO_LIVE_START_DATETIME,
--        MAX(DATEADD(HOUR, 8, SLRH_ENDED_AT)) AS VIDEO_LIVE_END_DATETIME,
--        MAX(DATEADD(HOUR, 8, SLRH_ENDED_AT)) - MIN(DATEADD(HOUR, 8, SLRH_STARTED_AT)) AS VIDEO_DURATION
--FROM BBC_CMS.BBC_LIVE_ROOMS_HISTORY
--GROUP BY SPID
--) AS H
--ON R.VIDEOID = H.SPID 
--)
--where RSH_TVB_PRODUCT = 'BBCL'
--and convert(date, VIDEO_LIVE_START_DATETIME) = '2017-11-02'

select count(1) as ARCHIVE_UPLOAD
from(
(select * from
 SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY) R


LEFT JOIN
(select spid,
        min(dateadd(hour, 8, svu_created_at)) as video_upload_datetime
from bbc_cms.bbc_video_uploads
group by spid
) AS H
ON R.VIDEOID = H.SPID 
)
where RSH_TVB_PRODUCT = 'BBCL'
and convert(date, video_upload_datetime) = '2017-11-02'