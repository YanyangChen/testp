import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.*;   // Use 'Connection', 'Statement' and 'ResultSet' classes in java.sql package

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
// JDK 1.7 and above
public class JdbcSelectTest {   // Save as "JdbcSelectTest.java"
   public static void main(String[] args) throws Exception, Throwable, Throwable {
	   Connection conn = null;		
		String output = "";	
     try  {
         // Step 3: Execute a SQL SELECT query, the query result
         //  is returned in a 'ResultSet' object.
    	 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://tvbcsveis05;integratedSecurity=true;DatabaseName=SC_ETL_NEW";			
			conn = DriverManager.getConnection(url);
			Statement stmt = conn.createStatement();
//			File f=new File("..\\sql\\SVdaily.sql");
			Path inputPath = Paths.get("sql\\SVdaily.sql");
			StringBuilder querry = new StringBuilder();
			//read sql from file
			
			try(BufferedReader rdr = Files.newBufferedReader(inputPath);
					)
			{
				
				while (rdr.ready())
				{
					String line = rdr.readLine();
					querry.append(line);
					
				}
			} catch (java.io.IOException x)
			{
				System.err.println("error reading sql");
			}
			System.out.println(querry);

         System.out.println("The SQL query is: " + querry); // Echo For debugging
         System.out.println();
 
         ResultSet rset = stmt.executeQuery(querry.toString());
         System.out.println("The records selected are:");
         int rowCount = 0;
//       while(rset.next()) {   
// 			  Move the cursor to the next row, return false if no more row
//            String ua = rset.getString("ua");
//            String visitor = rset.getString("visitor");
//            int    timespent   = rset.getInt("timespent");
//            System.out.println(ua + ", " + visitor + ", " + timespent);
//            ++rowCount;
//         }
        
         //create a new workbook, sheet and row
         Workbook wb = new HSSFWorkbook();

         Sheet sheet = wb.createSheet("SVDaily");
         
         
         //get column names from result set
         ResultSetMetaData rsmd = rset.getMetaData();
        
         //set the column name
//         for (int i = 0; i <  rsmd.getColumnCount()-1; i++) {
//             Cell cell = headerRow.createCell(i);
//             System.out.println(rsmd.getColumnName(i));
//             cell.setCellValue(rsmd.getColumnName(i));
//         }
         //set row values
         Row headerRow = sheet.createRow(rowCount);
         for (int i = 1; i <  rsmd.getColumnCount()+1; i++) { 
         	Cell cell = headerRow.createCell(i-1);
         	 cell.setCellValue(rsmd.getColumnName(i));
         	 }
         rowCount++;
         while (rset.next())
         {
        	
        	 //getString starts from column 1
        	 Row contentRow = sheet.createRow(rowCount);
        	 for (int i = 1; i <  rsmd.getColumnCount()+1; i++) { 
        		 
                 Cell cell = contentRow.createCell(i-1);
                
                 cell.setCellValue(rset.getString(i));
                 //System.out.println(rsmd.getColumnName(0));
                
             } 
        	 ++rowCount;
         }
         System.out.println("Total number of records = " + rowCount);
         //Write the output to a file
         String file = "businessplan.xls";
         FileOutputStream out = new FileOutputStream(file);
         wb.write(out);
         out.close();
         wb.close();
      } catch(SQLException ex) {
         ex.printStackTrace();
      }
      // Step 5: Close the resources - Done automatically by try-with-resources
   }
}