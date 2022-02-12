import java.net.*;
import java.io.*;
public class StdenvHttpConnection
{
public static void main (String[] foAString)
	throws Exception
 {
    URL url;
    HttpURLConnection connection = null;  
    String target = (foAString.length >= 1) ?  foAString[0] : "http://127.0.0.1";
	System.out.printf("Trying to http GET %s\n", target);
    try {
      //Create connection
      url = new URL(target);
      connection = (HttpURLConnection)url.openConnection();
      connection.setDoInput(true);
      connection.setDoOutput(true);

      InputStream is = connection.getInputStream();
      BufferedReader rd = new BufferedReader(new InputStreamReader(is));
      String line;
      StringBuffer response = new StringBuffer(); 
      while((line = rd.readLine()) != null) {
		  System.out.println(line);
      }
      rd.close();


    } finally {

      if(connection != null) {
        connection.disconnect(); 
      }
    }
  }
}
