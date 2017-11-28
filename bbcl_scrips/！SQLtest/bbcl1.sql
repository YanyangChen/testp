SELECT 
F.video_title,
COUNT(F.stream_views) AS STB,
COUNT(F.stream_visitor) AS WEB,
FROM
(select 
video_title,
rsh_device,
(case
when 
rsh_device = 'STB'
then 'STB'
end) as c_STB,
(case
when 
rsh_device = 'WEB'
then 'WEB'
end) as c_WEB,
(case
when 
rsh_device = 'APP'
then 'APP'
end) as c_APP

from dbo.IMPORTSTREAM_SUMMARY_NEW_ADHOC) F
GROUP BY video_title --changed