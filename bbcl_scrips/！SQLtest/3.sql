SELECT 
F.video_stage,
COUNT(F.c_STB) AS STB,
COUNT(F.c_WEB) AS WEB,
COUNT(F.c_APP) AS APP
FROM
(select 
video_stage,
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
GROUP BY video_stage