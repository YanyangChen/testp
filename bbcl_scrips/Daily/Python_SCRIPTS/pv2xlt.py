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
+"HKDATE,"
+"count(1) as PV,"
+"        count(distinct VISITOR) as UB "
+"from SC_ETL_NEW.dbo.V_IMPORTWEB "
+"where HKDATE = '2017-11-02' "
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
	print('row = %r' % (row[1],))
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
	
	
# psrows = cursor.execute("select  "
# +"RSH_TVB_PRODUCT AS PRODUCT, "
# +"RSH_TVB_PRODUCT_CATEGORY AS CATEGORY, "
# +"RSH_DEVICE_DETAIL, "
# +"'ALL' AS CITYNAME, "
# +"RSH_DEVICE_DETAIL AS DEVICE, "
# +"'ALL' AS CITYNAME, "
# +"'2017-11-03'HKDATE, "
# +"count(distinct VISITOR+UA+VIDEOID+UPID) as SV, "
# +"        count(distinct VISITOR) as USB, "
# +"        sum(TIMESPENT) as DURATION "
# +"from SC_ETL_NEW.dbo.IMPORTSTREAM_SUMMARY_NEW_1DAY "
# +"where RSH_TVB_PRODUCT = 'BBCL' "
# +"GROUP BY RSH_TVB_PRODUCT, RSH_DEVICE_DETAIL, RSH_DEVICE_DETAIL, RSH_TVB_PRODUCT_CATEGORY ")
    
	
# ws2 = wb.add_sheet('A 2nd Test Sheet', cell_overwrite_ok=True)
# for psrow in psrows:
	# ws.write(counter+6, 0, row[0])
	# ws.write(counter+6, 1, row[1])
	# ws.write(counter+6, 2, row[2])
	# ws.write(counter+6, 3, row[3])
	# ws.write(counter+6, 4, row[4])
	# ws.write(counter+6, 5, row[5])
	# ws.write(counter+6, 6, row[6])


	# print()

	
	
	
	
	
	
	
	
	
	

# ws.write(0, 0, 1234.56, style0)
# ws.write(1, 0, datetime.now(), style1)
# # testing: put table row data to excel
# ws.write(2, 0, row[3])
# ws.write(2, 1, row[3])

# # using excel formula
# ws.write(2, 2, xlwt.Formula("A3+B3"))

# output to excel file
#xlsxwriter.Workbook('C:/Users/ac21611/Documents/demo.xlsx')
wb.save('C:/Users/ac21611/Desktop/bbcl_scrips/Daily/example3.xls')