import pyodbc 
import xlwt
from datetime import datetime

# defines excek styleas
style0 = xlwt.easyxf('font: name Times New Roman, color-index red, bold on',
    num_format_str='#,##0.00')
style1 = xlwt.easyxf(num_format_str='D-MMM-YY')

# connect to DB
cnxn = pyodbc.connect("Driver={ODBC Driver 13 for SQL Server};"
                      "server=tvbcsveis05;"
                      "Database=SC_ETL_NEW;"
                      "Trusted_Connection=yes")


cursor = cnxn.cursor()

# with open('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/SQL_SCRIPTS/PV.txt, 'r') as myfile:
    # data=myfile.read().replace('\n', '');

rows = cursor.execute("select "
+"RSH_TVB_PRODUCT AS PRODUCT,"
+"'TOTAL' AS CATEGORY,"
+"RSH_DEVICE_DETAIL AS DEVICE,"
+"'ALL' AS CITYNAME,"
+" '2017-11-06' as HKDATE,"
+"count(1) as PV,"
+"        count(distinct VISITOR) as UB "
+"from SC_ETL_NEW.dbo.V_IMPORTWEB "
+"where HKDATE = '2017-11-06' "
+"and RSH_TVB_PRODUCT = 'BBCL' "
+"GROUP BY RSH_TVB_PRODUCT, HKDATE, RSH_DEVICE_DETAIL")

# extract one record from table
# row = cursor.fetchone()
#print(row[0])
wb = xlwt.Workbook()
# worksheet = workbook.add_sheet("Sheet 1", cell_overwrite_ok=True)
ws = wb.add_sheet('A Test Sheet', cell_overwrite_ok=True)
counter = 0;
totalpv = 0;
totalub = 0;
for row in rows:
	
	ws.write(counter+4, 0, row[0])
	ws.write(counter+4, 1, row[1])
	ws.write(counter+4, 2, row[2])
	ws.write(counter+4, 3, row[3])
	ws.write(counter+4, 4, row[4])
	ws.write(counter+4, 5, row[5])
	ws.write(counter+4, 6, row[6])
	# print('row = %r' % (row[1],))
	counter +=1;
	totalub += row[6];
	totalpv += row[5];
	# add total to cells
	ws.write(2, 5, totalpv)
	ws.write(2, 6, totalub)
	ws.write(3, 5, totalpv)
	ws.write(3, 6, totalub)
	# add dummies
	ws.write_merge(0, 0, 0, 6, 'Daily PV and UB')
	ws.write(1, 0, 'PRODUCT')
	ws.write(1, 1, 'CATEGORY')
	ws.write(1, 2, 'DEVICE')
	ws.write(1, 3, 'CITYNAME')
	ws.write(1, 4, 'HKDATE')
	ws.write(1, 5, 'PV')
	ws.write(1, 6, 'UB')
	ws.write(2, 0, row[0])
	ws.write(2, 1, row[1])
	ws.write(2, 2, 'ALL')
	ws.write(2, 3, row[3])
	ws.write(2, 4, row[4])
	ws.write(3, 0, row[0])
	ws.write(3, 1, row[1])
	ws.write(3, 2, 'APP')
	ws.write(3, 3, row[3])
	ws.write(3, 4, row[4])
	
 
print('1st part finished')

psrows = cursor.execute("select  "
+"RSH_TVB_PRODUCT AS PRODUCT, "
+"RSH_TVB_PRODUCT_CATEGORY AS CATEGORY, "
+"RSH_DEVICE_DETAIL AS DEVICE, "
+"'ALL' AS CITYNAME, "
+" '2017-11-06' AS HKDATE, "
+"count(distinct VISITOR+UA+VIDEOID+UPID) as SV, "
+"        count(distinct VISITOR) as USB, "
+"        sum(TIMESPENT) as DURATION "
+"from SC_ETL_NEW.dbo.V_IMPORTSTREAM_NEW "
+"where RSH_TVB_PRODUCT = 'BBCL' "
+"GROUP BY RSH_TVB_PRODUCT, RSH_TVB_PRODUCT_CATEGORY, RSH_DEVICE_DETAIL ")
    
# wb = xlwt.Workbook()
ws2 = wb.add_sheet('A 2nd Test Sheet', cell_overwrite_ok=True)
counter = 0;
for row in psrows:
	if counter <= 1: 
		ws2.write(counter+2, 0, row[0])
		ws2.write(counter+2, 1, row[1])
		ws2.write(counter+2, 2, row[2])
		ws2.write(counter+2, 3, row[3])
		ws2.write(counter+2, 4, row[4])

		ws2.write(counter+6, 0, row[0])
		ws2.write(counter+6, 1, row[1])
		ws2.write(counter+6, 2, row[2])
		ws2.write(counter+6, 3, row[3])
		ws2.write(counter+6, 4, row[4])
	
		ws2.write(counter+8, 0, row[0])
		ws2.write(counter+8, 1, row[1])
		ws2.write(counter+8, 2, row[2])
		ws2.write(counter+8, 3, row[3])
		ws2.write(counter+8, 4, row[4])
		ws2.write(counter+8, 5, row[5])
		ws2.write(counter+8, 6, row[6])
		ws2.write(counter+8, 7, row[7])
		
	if counter >1: 
		ws2.write(counter+2, 0, row[0])
		ws2.write(counter+2, 1, row[1])
		ws2.write(counter+2, 2, row[2])
		ws2.write(counter+2, 3, row[3])
		ws2.write(counter+2, 4, row[4])
	
	
		ws2.write(counter+8, 0, row[0])
		ws2.write(counter+8, 1, row[1])
		ws2.write(counter+8, 2, row[2])
		ws2.write(counter+8, 3, row[3])
		ws2.write(counter+8, 4, row[4])
	
		ws2.write(counter+10, 0, row[0])
		ws2.write(counter+10, 1, row[1])
		ws2.write(counter+10, 2, row[2])
		ws2.write(counter+10, 3, row[3])
		ws2.write(counter+10, 4, row[4])
		ws2.write(counter+10, 5, row[5])
		ws2.write(counter+10, 6, row[6])
		ws2.write(counter+10, 7, row[7])
	
	counter += 1;
	



	
	ws2.write(7-1, 5, xlwt.Formula("F9+F10"))
	ws2.write(7-1, 6, xlwt.Formula("G9+G10"))
	ws2.write(7-1, 7, xlwt.Formula("H9+H10"))
	ws2.write(8-1, 5, xlwt.Formula("F9+F10"))
	ws2.write(8-1, 6, xlwt.Formula("G9+G10"))
	ws2.write(8-1, 7, xlwt.Formula("H9+H10"))
	
	ws2.write(11-1, 5, xlwt.Formula("F13+F14"))
	ws2.write(11-1, 6, xlwt.Formula("G13+G14"))
	ws2.write(11-1, 7, xlwt.Formula("H13+H14"))
	ws2.write(12-1, 5, xlwt.Formula("F13+F14"))
	ws2.write(12-1, 6, xlwt.Formula("G13+G14"))
	ws2.write(12-1, 7, xlwt.Formula("H13+H14"))
	
		
	ws2.write(5-1, 5, xlwt.Formula("F9+F13"))
	ws2.write(5-1, 6, xlwt.Formula("G9+G13"))
	ws2.write(5-1, 7, xlwt.Formula("H9+H13"))
	ws2.write(6-1, 5, xlwt.Formula("F10+F14"))
	ws2.write(6-1, 6, xlwt.Formula("G10+G14"))
	ws2.write(6-1, 7, xlwt.Formula("H10+H14"))
	
	ws2.write(3-1, 5, xlwt.Formula("F5+F6"))
	ws2.write(3-1, 6, xlwt.Formula("G5+G6"))
	ws2.write(3-1, 7, xlwt.Formula("H5+H6"))
	ws2.write(4-1, 5, xlwt.Formula("F5+F6"))
	ws2.write(4-1, 6, xlwt.Formula("G5+G6"))
	ws2.write(4-1, 7, xlwt.Formula("H5+H6"))
	
	# Daily SV , USB and Duration							
ws2.write_merge(0, 0, 0, 7, 'Daily SV , USB and Duration	')
	# PRODUCT	CATEGORY	DEVICE	CITYNAME	HKDATE	SV	USB	DURATION
ws2.write(1, 0, 'PRODUCT')
ws2.write(1, 1, 'CATEGORY')
ws2.write(1, 2, 'DEVICE')
ws2.write(1, 3, 'CITYNAME')
ws2.write(1, 4, 'HKDATE')
ws2.write(1, 5, 'SV')
ws2.write(1, 6, 'USB')
ws2.write(1, 7, 'DURATION')
	
	
for i in range(12):
	
	if i < 5 and i > 0: ws2.write(i-1+2, 1, 'Total')
	
	if i%4 ==1:
		ws2.write(i-1+2, 2, 'ALL')
		
	if i%4 ==2:
		ws2.write(i-1+2, 2, 'APP')
	if i%4 ==3:
		ws2.write(i-1+2, 2, 'APP-iOS')
	if i%4 ==0:
		
		if i ==0:
			ws2.write(13, 2, 'APP-Android')
			continue;
		
		# if i == 11: 
			# ws2.write(13, 2, 'APP-Android')
			# print()
		ws2.write(i-1+2, 2, 'APP-Android')
# print()

print('2nd part finished')


crows = cursor.execute(
" select sp_type, "
+"        count(spid) as video_count "
+"from (select a.spid, "
+"              a.sp_type, "
+"             a.sp_content, "
+"             a.sauid, "
+"              d.sau_nickname, "
+"             dateadd(hour, 8, a.sp_created_at) as video_last_create_datetime, "
+"              b.video_upload_datetime, "
+"              c.video_live_start_datetime, "
+"              c.video_live_end_datetime, "
+"              c.video_duration "
+"       from (select * "
+"              from bbc_cms.bbc_posts "
+"              where BATCH_DATE = '2017-11-06') as a "
+"              left join (select spid, "
+"                                  min(dateadd(hour, 8, svu_created_at)) as video_upload_datetime "
+"                          from bbc_cms.bbc_video_uploads "
+"                          group by spid) as b "
+"              on a.spid = b.spid "
+"              left join (select spid, "
+"                                  min(dateadd(hour, 8, slrh_started_at)) as video_live_start_datetime, "
+"                                  max(dateadd(hour, 8, slrh_ended_at)) as video_live_end_datetime, "
+"                                  max(dateadd(hour, 8, slrh_ended_at)) - min(dateadd(hour, 8, slrh_started_at)) as video_duration "
+"                          from bbc_cms.bbc_live_rooms_history "
+"                          group by spid) as c "
+"              on a.spid = c.spid "
+"              left join (select * "
+"                          from bbc_cms.bbc_app_users "
+"                          where sau_user_type = 'performer') as d "
+"              on a.sauid = d.sauid "
+"       where convert(date, (case when c.video_live_start_datetime is not null "
+"                                     then c.video_live_start_datetime "
+"                                     when b.video_upload_datetime is not null "
+"                                     then b.video_upload_datetime "
+"                                     else dateadd(hour, 8, a.sp_created_at) end)) = '2017-11-06') as z group by sp_type ")

ws3 = wb.add_sheet('A 3rd Test Sheet', cell_overwrite_ok=True)
counter = 0;
ws3.write_merge(0, 0, 0, 1, '	Newly uploaded videos  ')
ws3.write(1, 0, 'VIDEO_TYPE')
ws3.write(1, 1, 'VIDEO_COUNT')
for row in crows:
	ws3.write(counter+2, 0, row[0])
	ws3.write(counter+2, 1, row[1])
	counter += 1;
	

print('3rd part finished')
print('work done')
wb.save('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/svexample01.xls')