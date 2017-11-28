SELECT 
DISTINCT
SP_CONTENT as Video_title,
sau_nickname AS VIDEO_OWNER,
H.SLRH_STARTED_AT AS START_DATE,
H.SLRH_ENDED_AT AS END_DATE,
COUNT(CONCAT(UA, VISITOR, UPID, VIDEOID)) AS STREAM_VIEWS,
 /*TAKE MUID AS UNIQUE VISITOR*/
COUNT(DISTINCT MUID) AS UNIQUE_STREAM_VIEWS,
SUM(TIMESPENT) AS TTL_TS,
COUNT(L_SV) AS L_STREAM_VIEWS,
COUNT(DISTINCT L_VISITOR) AS L_UNIQUE_STREAM_VIEWS,
SUM( L_TIMESPENT) AS L_TTL_TS,
COUNT(A_SV) AS A_VSTREAM_VIEWS,
COUNT(DISTINCT A_VISITOR) AS A_UNIQUE_STREAM_VIEWS,
SUM( A_TIMESPENT) AS A_TTL_TS
	
	FROM /* BBCL_TABLE */
	((select S.*, M.*,
  (CASE
  /*TAKE MUID AS UNIQUE VISITOR*/
	WHEN UA IN ('48', '49') THEN MUID ELSE NULL /*UA 48 49 stands for live*/
	END) AS L_VISITOR,
  (CASE
	WHEN UA IN ('48', '49') THEN CONCAT(UA, VISITOR, UPID, VIDEOID) ELSE NULL/*using concat to make sure a absolute stream view*/
	END) AS L_SV,
	(CASE
	WHEN UA IN ('48', '49') THEN TIMESPENT ELSE NULL
	END) AS L_TIMESPENT,
	(CASE
   /*TAKE MUID AS UNIQUE VISITOR*/
	WHEN UA IN ('50', '51') THEN MUID ELSE NULL /*UA 50 51 stands for upload*/
	END) AS A_VISITOR,
  (CASE
  WHEN UA IN ('50', '51') THEN CONCAT(UA, VISITOR, UPID, VIDEOID) ELSE NULL
	END) AS A_SV,
	(CASE
	WHEN UA IN ('50', '51') THEN TIMESPENT ELSE NULL
	END) AS A_TIMESPENT
      from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_ADHOC S
/* we usually use left join to prevent missing records */

/*left join bbc_posts table to get video type(sp_type) and content(sp_content) */
      left join (select SPID, SP_TYPE, SP_CONTENT
            from bbc_cms.bbc_posts
            where BATCH_DATE = (select max(BATCH_DATE) from bbc_cms.bbc_posts)) M /* get the lastest image of bbc_posts */
      on S.VIDEOID = M.SPID
      where convert(date, HKDATETIME) > '2017-10-23' and convert(date, HKDATETIME) < '2017-11-01'
      and UA in ('48', '49', '50', '51')) AS R

/*left join bbc_live_rooms_history table to calculate duration */
LEFT JOIN
(SELECT *, CONVERT(TIME,(SLRH.SLRH_ENDED_AT - SLRH.SLRH_STARTED_AT)) AS DURATION
FROM bbc_cms.bbc_live_rooms_history SLRH) AS H
ON R.VIDEOID = H.SPID 

LEFT JOIN
(SELECT sauid ,sau_nickname
FROM SC_ETL_NEW.bbc_cms.bbc_app_users) AS N /*get video owner name from app_user table*/
ON R.VIDEO_OWNER = N.SAUID)
GROUP BY SP_CONTENT, sau_nickname, H.SLRH_STARTED_AT, H.SLRH_ENDED_AT
