
import java.io.BufferedReader;
 import java.io.BufferedWriter;      
 import java.io.File;      
 import java.io.FileFilter;      
 import java.io.FileInputStream;      
 import java.io.FileOutputStream;      
 import java.io.IOException;      
 import java.io.InputStream;      
 import java.io.InputStreamReader;      
 import java.io.OutputStream;      
 import java.io.OutputStreamWriter;      
 import java.io.Reader;      
 import java.io.UnsupportedEncodingException;      
import java.io.Writer; 
import java.text.DateFormat;
import java.util.Date;

 public class EncodeConverter_stephen {  
        
     private static String srcDir = "C:\\SIS Team\\Nielsen Raw Data\\Testing Raw Data\\nielsen_dump\\src";
     
     private static String desDir = "C:\\SIS Team\\Nielsen Raw Data\\Testing Raw Data\\nielsen_dump\\des";
          
     private static String srcEncode = "UTF-8";
     
     private static String desEncode = "Big5";
            
     private static FileFilter filter = new FileFilter() {      
         public boolean accept(File pathname) {      
            
             if (pathname.isDirectory()      
                     || (pathname.isFile() && pathname.getName().endsWith(      
                             ".csv")))      
                 return true;      
             else     
                 return false;      
         }      
     };      
           
     /**    
      * @param file    
      */     
     public static void readDir(File file)      
     {      
 
         File[] files = file.listFiles(filter);     
         for (File subFile : files) {      
                  
             if (subFile.isDirectory()) {      
                 File file3 = new File(desDir + subFile.getAbsolutePath().substring(srcDir.length()));      
                 if (!file3.exists()) {      
                     file3.mkdir();      
                 }      
                 file3 = null;      
                 readDir(subFile);      
             } else {    

                 System.err.println("Source File�t"+subFile.getAbsolutePath() + "\nTarget File�t" + (desDir + subFile.getAbsolutePath().substring(srcDir.length())));      
                 System.err.println("-----------------------------------------------------------------");
                 System.out.println("Start Time : "+DateFormat.getDateTimeInstance().format(new Date()));
                 try {      
                     convert(subFile.getAbsolutePath(), desDir + subFile.getAbsolutePath().substring(srcDir.length()), srcEncode, desEncode);      
                 } catch (UnsupportedEncodingException e) {      
                     e.printStackTrace();      
                 } catch (IOException e) {      
                     e.printStackTrace();      
                 } 
                 System.out.println("End Time : "+DateFormat.getDateTimeInstance().format(new Date()));
             }      
         }      
     }      
           
     public static void convert(String infile, String outfile, String from,      
             String to) throws IOException, UnsupportedEncodingException {      
         // set up byte streams      
         InputStream in;      
         if (infile != null)      
             in = new FileInputStream(infile);      
         else     
             in = System.in;      
         OutputStream out;      
         if (outfile != null)      
             out = new FileOutputStream(outfile);      
         else     
             out = System.out;      
      
         // Use default encoding if no encoding is specified.      
         if (from == null)      
             from = System.getProperty("file.encoding");      
         if (to == null)      
             to = System.getProperty("file.encoding");      
      
         // Set up character stream      
         Reader r = new BufferedReader(new InputStreamReader(in, from));      
         Writer w = new BufferedWriter(new OutputStreamWriter(out, to));      
      
         // Copy characters from input to output. The InputStreamReader      
         // converts from the input encoding to Unicode,, and the      
         // OutputStreamWriter      
         // converts from Unicode to the output encoding. Characters that cannot      
         // be      
         // represented in the output encoding are output as '?'      
         char[] buffer = new char[4096];      
         int len;      
         while ((len = r.read(buffer)) != -1)           
             w.write(buffer, 0, len);             
         r.close();      
         w.flush();      
         w.close();      
     }      
           
      
     public static void main(String[] args) {      
           
         File desFile = new File(desDir);      
         if (!desFile.exists()) {      
             desFile.mkdir();      
         }      
         desFile = null;      
      
         File srcFile = new File(srcDir);
        
         readDir(srcFile);      
         srcFile = null;      
     }   
 }  
