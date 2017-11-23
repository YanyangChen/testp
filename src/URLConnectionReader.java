
import java.net.*;
import java.util.ArrayList;
import java.util.List;
import java.io.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

class ac{
	public String long_name;
	public String Short_name;
	public List<String> types;
}

class rts{
	public String formatted_address;
	public ac address_components[];
	
}


class Gmap {
	
	public rts results[] ;
	public String status;
}



public class URLConnectionReader {
    public static void main(String[] args) throws Exception {
    	location loc = new location();
    	
//    	sending http request to get object
        URL yahoo = new URL("https://maps.googleapis.com/maps/api/geocode/json?latlng=22.3773986442252,114.102963940563&key=AIzaSyBzNS76oQ_bDc_72ZxpXqAMNetVl46lW6o");
        URLConnection yc = yahoo.openConnection();
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                yc.getInputStream()));
        String inputLine;
        StringBuilder JsonStr = new StringBuilder();
        int counter = 0;
        while ((inputLine = in.readLine()) != null) 
            {System.out.println(inputLine);
            JsonStr.append(inputLine.trim());
        	counter++;}
        in.close();
        System.out.println(counter);
        System.out.println(JsonStr.toString().concat(JsonStr.toString()));
//        ObjectMapper mapper = new ObjectMapper();
        Gson gson = new GsonBuilder().create();
        Gmap p = gson.fromJson(JsonStr.toString(), Gmap.class);
        System.out.println(p.status); //OBJECT name must be the same
        System.out.println(p.results[0].formatted_address);
//        System.out.println(p.results[0].);//district
        System.out.println(p.results[0].address_components[4].long_name);//district
        System.out.println(p.results[0].address_components[3].long_name);//region 
    }
}