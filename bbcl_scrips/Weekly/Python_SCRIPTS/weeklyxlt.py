import pyodbc 
import xlwt
from xlwt import *
from datetime import datetime
import sqlite3
from sqlite3 import OperationalError
# defines excek styleas
style0 = xlwt.easyxf('font: name Times New Roman, color-index red, bold on',
    num_format_str='#,##0.00')
style1 = xlwt.easyxf(num_format_str='D-MMM-YY')


# input_date = str(input('please input the report batch date: inthe format \'2017-11-01\':' ))
input_start_date = "'" + str(input('please input the report start date: in the format 2017-11-01:' )) + "'"
input_end_date = "'" + str(input('please input the report end date: in the format 2017-11-01:' )) + "'"
# connect to DB
cnxn = pyodbc.connect("Driver={ODBC Driver 13 for SQL Server};"
                      "server=tvbcsveis05;"
                      "Database=SC_ETL_NEW;"
                      "Trusted_Connection=yes")


cursor = cnxn.cursor()

# a = "Hi, my name is %s and I have a %s hat" % ("Azeirah", "cool")
# print(a)
# >>> Hi, my name is Azeirah and I have a Cool hat

# https://stackoverflow.com/questions/3395138/using-multiple-arguments-for-string-formatting-in-python-e-g-s-s
# %(last)s, %(first)s %(last)s' % {'first': "James", 'last': "Bond"}

# reading sql: https://stackoverflow.com/questions/19472922/reading-external-sql-script-in-python
fd = open('C:/Users/ac21611/Desktop/bbcl_scrips/Weekly/SQL_SCRIPTS/LIVE_WEEKLY_PERFORMANCE_REPORT_wp.sql', 'r')
sqlFile = fd.read()
fd.close()
rows = cursor.execute(sqlFile % {'start_date': input_start_date, 'end_date': input_end_date});


# extract one record from table
# row = cursor.fetchone()
#print(row[0])
wb = xlwt.Workbook()
# worksheet = workbook.add_sheet("Sheet 1", cell_overwrite_ok=True)
ws = wb.add_sheet('A Test Sheet', cell_overwrite_ok=True)
counter = 0;
style = XFStyle()
style.num_format_str = 'M/D/YY h:mm'

for row in rows:

	for i in range(len(row)):
		if i > 4 and i < 9:
			ws.write(counter+2, i, row[i], style);
			continue;
		ws.write(counter+2,i,row[i])
	counter += 1;

columns = [column[0] for column in cursor.description];
for i in range(len(columns)):
	ws.write(1,i,columns[i])
ws.write_merge(0, 0, 0, 47, 'Weekly report: live video listing')
print('done');




wb.save('C:/Users/ac21611/Desktop/bbcl_scrips/weekly/examplex%s.xls' % (input_end_date))