import pyodbc 
import xlwt
from datetime import datetime

# defines excek styleas
input_date = "'" + str(input('please input the report date: in the format 2017-11-01:' )) + "'"
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

fd = open('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/SQL_SCRIPTS/PV.sql', 'r')
sqlFile = fd.read()
fd.close()
rows = cursor.execute(sqlFile % {'date': input_date});

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
fd = open('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/SQL_SCRIPTS/SV.sql', 'r')
sqlFile = fd.read()
fd.close()
psrows = cursor.execute(sqlFile % {'date': input_date});

    
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

fd = open('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/SQL_SCRIPTS/VC.sql', 'r')
sqlFile = fd.read()
fd.close()
crows = cursor.execute(sqlFile % {'date': input_date});


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
wb.save('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/sv%s.xls' % (input_date))