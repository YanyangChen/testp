import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class Excellocation {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			 String file = "lalon.xls";
		    POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream(file));
		    HSSFWorkbook wb = new HSSFWorkbook(fs);
		    HSSFWorkbook wwb = new HSSFWorkbook();
		    HSSFSheet sheet = wb.getSheetAt(0);
		    HSSFSheet sheet2 = wwb.createSheet("address_added"); //sheet for writing new address
		    HSSFRow row;
		    HSSFCell cell;

		    int rows; // No of rows
		    rows = sheet.getPhysicalNumberOfRows();

		    int cols = 0; // No of columns
		    int tmp = 0;
		    ArrayList<location> AL_Loc = new ArrayList<location>();
		    // This trick ensures that we get the data properly even if it doesn't start from first few rows
		    for(int i = 0; i < 10 || i < rows; i++) {
		        row = sheet.getRow(i);
		        if(row != null) {
		            tmp = sheet.getRow(i).getPhysicalNumberOfCells();
		            if(tmp > cols) cols = tmp;
		        }
		    }
		    
		    
		    //read data from input excel file
		    for(int r = 1; r < 10; r++) { //r < rows
		        row = sheet.getRow(r); //sheet points to input source excel's sheet
		        if(row != null) {
		        	location lloc = new location();
		            for(int c = 0;  c <= 4; c++) {
		                cell = row.getCell((short)c);
		                if(cell != null) {
		                    // Your code here
		                	if (c == 0)
		                	{
		                		
		                		lloc.device_id = cell.getStringCellValue();
		                	}
		                	if (c == 1)
		                	{
		                		
		                		lloc.lat = cell.getNumericCellValue();
		                	}
		                	if (c == 2)
		                	{
		                		lloc.lon = cell.getNumericCellValue();
		                	}
		                	if (c == 3)
		                	{
		                		
		                		lloc.create = cell.getDateCellValue();
		                	}
		                	if (c == 4)
		                	{
		                		
		                		lloc.update = cell.getDateCellValue();
		                	}
		                }
		            }
		            //compute location and store inside instant objects
		            lloc.convertloc2addr();
		            
		            //then add the objects to the ArrayList of those objects
		            AL_Loc.add(lloc);
		           
		        }
		    }
		    
		    //output the arraylist to the FileOutputStream excel
		    String file2 = "addrr.xls";
	         FileOutputStream out = new FileOutputStream(file2);
	         for (int i = 0; i < AL_Loc.size(); i++)
	         {
	        	 Row contentRow = sheet2.createRow(i+1);
//		            Cell wcell = contentRow.createCell(5); //write address to the 5th column
	        	 	contentRow.createCell(7).setCellValue(AL_Loc.get(i).update);
		            contentRow.createCell(6).setCellValue(AL_Loc.get(i).create);
		            contentRow.createCell(5).setCellValue(AL_Loc.get(i).address);
		            contentRow.createCell(4).setCellValue(AL_Loc.get(i).district);
		            contentRow.createCell(3).setCellValue(AL_Loc.get(i).region);
		            contentRow.createCell(2).setCellValue(AL_Loc.get(i).lon);
		            contentRow.createCell(1).setCellValue(AL_Loc.get(i).lat);
		            contentRow.createCell(0).setCellValue(AL_Loc.get(i).device_id);
	         }
	        
	         wwb.write(out);
	         out.close();
	         wwb.close();
		    System.out.println(AL_Loc.get(0).address);
		   
		} catch(Exception ioe) {
		    ioe.printStackTrace();
		}
	}

}
