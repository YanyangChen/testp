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

psrows = cursor.execute("select  "
+"RSH_TVB_PRODUCT AS PRODUCT, "
+"RSH_TVB_PRODUCT_CATEGORY AS CATEGORY, "
+"RSH_DEVICE_DETAIL AS DEVICE, "
+"'ALL' AS CITYNAME, "
+"'2017-11-03'HKDATE, "
+"count(distinct VISITOR+UA+VIDEOID+UPID) as SV, "
+"        count(distinct VISITOR) as USB, "
+"        sum(TIMESPENT) as DURATION "
+"from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY "
+"where RSH_TVB_PRODUCT = 'BBCL' "
+"GROUP BY RSH_TVB_PRODUCT, RSH_TVB_PRODUCT_CATEGORY, RSH_DEVICE_DETAIL ")
    
wb = xlwt.Workbook()
ws = wb.add_sheet('A 2nd Test Sheet', cell_overwrite_ok=True)
counter = 0;
liveiossv = 0;
liveiosusb = 0;
liveiosduration = 0;
liveandroidsv = 0;
liveliveandroidusb = 0;
liveliveandroidduration = 0;
for row in psrows:
	if counter <= 1: 
		ws.write(counter+2, 0, row[0])
		ws.write(counter+2, 1, row[1])
		ws.write(counter+2, 2, row[2])
		ws.write(counter+2, 3, row[3])
		ws.write(counter+2, 4, row[4])

		ws.write(counter+6, 0, row[0])
		ws.write(counter+6, 1, row[1])
		ws.write(counter+6, 2, row[2])
		ws.write(counter+6, 3, row[3])
		ws.write(counter+6, 4, row[4])
	
		ws.write(counter+8, 0, row[0])
		ws.write(counter+8, 1, row[1])
		ws.write(counter+8, 2, row[2])
		ws.write(counter+8, 3, row[3])
		ws.write(counter+8, 4, row[4])
		ws.write(counter+8, 5, row[5])
		ws.write(counter+8, 6, row[6])
		ws.write(counter+8, 7, row[7])
		
	if counter >1: 
		ws.write(counter+2, 0, row[0])
		ws.write(counter+2, 1, row[1])
		ws.write(counter+2, 2, row[2])
		ws.write(counter+2, 3, row[3])
		ws.write(counter+2, 4, row[4])
	
	
		ws.write(counter+8, 0, row[0])
		ws.write(counter+8, 1, row[1])
		ws.write(counter+8, 2, row[2])
		ws.write(counter+8, 3, row[3])
		ws.write(counter+8, 4, row[4])
	
		ws.write(counter+10, 0, row[0])
		ws.write(counter+10, 1, row[1])
		ws.write(counter+10, 2, row[2])
		ws.write(counter+10, 3, row[3])
		ws.write(counter+10, 4, row[4])
		ws.write(counter+10, 5, row[5])
		ws.write(counter+10, 6, row[6])
		ws.write(counter+10, 7, row[7])
	
	counter += 1;
	



	
	ws.write(7-1, 5, xlwt.Formula("F9+F10"))
	ws.write(7-1, 6, xlwt.Formula("G9+G10"))
	ws.write(7-1, 7, xlwt.Formula("H9+H10"))
	ws.write(8-1, 5, xlwt.Formula("F9+F10"))
	ws.write(8-1, 6, xlwt.Formula("G9+G10"))
	ws.write(8-1, 7, xlwt.Formula("H9+H10"))
	
	ws.write(11-1, 5, xlwt.Formula("F13+F14"))
	ws.write(11-1, 6, xlwt.Formula("G13+G14"))
	ws.write(11-1, 7, xlwt.Formula("H13+H14"))
	ws.write(12-1, 5, xlwt.Formula("F13+F14"))
	ws.write(12-1, 6, xlwt.Formula("G13+G14"))
	ws.write(12-1, 7, xlwt.Formula("H13+H14"))
	
		
	ws.write(5-1, 5, xlwt.Formula("F9+F13"))
	ws.write(5-1, 6, xlwt.Formula("G9+G13"))
	ws.write(5-1, 7, xlwt.Formula("H9+H13"))
	ws.write(6-1, 5, xlwt.Formula("F10+F14"))
	ws.write(6-1, 6, xlwt.Formula("G10+G14"))
	ws.write(6-1, 7, xlwt.Formula("H10+H14"))
	
	ws.write(3-1, 5, xlwt.Formula("F5+F6"))
	ws.write(3-1, 6, xlwt.Formula("G5+G6"))
	ws.write(3-1, 7, xlwt.Formula("H5+H6"))
	ws.write(4-1, 5, xlwt.Formula("F5+F6"))
	ws.write(4-1, 6, xlwt.Formula("G5+G6"))
	ws.write(4-1, 7, xlwt.Formula("H5+H6"))
	
	# Daily SV , USB and Duration							
ws.write_merge(0, 0, 0, 7, 'Daily SV , USB and Duration	')
	# PRODUCT	CATEGORY	DEVICE	CITYNAME	HKDATE	SV	USB	DURATION
ws.write(1, 0, 'PRODUCT')
ws.write(1, 1, 'CATEGORY')
ws.write(1, 2, 'DEVICE')
ws.write(1, 3, 'CITYNAME')
ws.write(1, 4, 'HKDATE')
ws.write(1, 5, 'SV')
ws.write(1, 6, 'USB')
ws.write(1, 7, 'DURATION')
	
	
for i in range(12):
	
	if i < 5 and i > 0: ws.write(i-1+2, 1, 'Total')
	
	if i%4 ==1:
		ws.write(i-1+2, 2, 'ALL')
		
	if i%4 ==2:
		ws.write(i-1+2, 2, 'APP')
	if i%4 ==3:
		ws.write(i-1+2, 2, 'APP-iOS')
	if i%4 ==0:
		
		if i ==0:
			ws.write(13, 2, 'APP-Android')
			continue;
		
		# if i == 11: 
			# ws.write(13, 2, 'APP-Android')
			# print()
		ws.write(i-1+2, 2, 'APP-Android')
print()
	
	
print('work done')
wb.save('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/svexample.xls')