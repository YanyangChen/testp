import eu.bitm.NominatimReverseGeocoding.*;
import eu.bitm.*;

import java.net.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.apache.commons.io.*;
import org.apache.commons.io.comparator.*;
import org.apache.commons.io.filefilter.*;
import org.apache.commons.io.input.*;
import org.apache.commons.io.monitor.*;
import org.apache.commons.io.output.*;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

class location{
	public String device_id;
	public Double lat;
	public Double lon;
	public String region;//getCounty()
	public String district;//getRegion()
	public String address;
	public Date create;
	public Date update;
	public ArrayList<String> addarray=new ArrayList<String>(10);;
	
	public location(String id, Double latitude, Double longitude){
	 this.device_id = id;
	 this.lat = latitude;
	 this.lon = longitude;
	}
	
	public location() {
		 this.device_id = "";
		 this.lat = 0d;
		 this.lon = 0d;
	}
	
	public void convertloc2addr() throws IOException
	{
//    	sending http request to get object
		String surl = "";
		surl = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
			+ this.lat.toString() + "," + this.lon.toString()
			+ "&key=AIzaSyBzNS76oQ_bDc_72ZxpXqAMNetVl46lW6o";
        URL g_request = new URL(surl);
        URLConnection yc = g_request.openConnection();
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
       // System.out.println(p.status); //OBJECT name must be the same
       // System.out.println(p.results[0].formatted_address);
		this.address = p.results[0].formatted_address;
//		this.region = p.results[0].address_components[p.results[0].address_components.length - 1].long_name;
//		this.district = p.results[0].address_components[p.results[0].address_components.length - 2].long_name;
//		if (this.district.equals("Kowloon")) {
//			this.region = "Kowloon";
//			this.district = "";
		for (int i = 1; i <= p.results[0].address_components.length-1; i++)
		{

		this.addarray.add(p.results[0].address_components[i].long_name); 
		}
		this.region = addarray.get(addarray.indexOf("Hong Kong")-1);
		this.district = addarray.get(addarray.indexOf("Hong Kong")-2);
		}
	}


public class loc2add {

	public static void main(String[] args) {
		System.out.println("Hi");
		NominatimReverseGeocodingJAPI nominatim1 = new NominatimReverseGeocodingJAPI(18);
		nominatim1.getAdress(22.3185855159517, 114.178212642094);
		//testing
		
//		getOsmId
//		getOsmType
//		getLod
//		getCountryCode
//		getCountry
//		getPostcode
//		getState
//		getCounty
//		getCity
//		getSuburb
//		getRoad
//		getDisplayName
//		
		System.out.println(nominatim1.getAdress(22.2942782863814d, 114.240952603959d).getDisplayName());
		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getDisplayName());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getSuburb());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getState());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getCountry());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getCounty());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getOsmId());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getOsmType());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getPostcode());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getRoad());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getCountry());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getOsmType());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getCountryCode());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).hashCode());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getCity());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getOsmType());
//		System.out.println(nominatim1.getAdress(22.3185855159517d, 114.178212642094d).getOsmType());
		
		//required format : number, road, district, country
		
		//import from to array of objects
		
		//using for loops to get address for each objects
		
		//export the objects to a new excel file
	}

}
