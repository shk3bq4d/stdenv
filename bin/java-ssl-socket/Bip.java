import java.net.*;
import java.io.*;
public class Bip
{
public static void main (String[] foAString)
	throws Exception
 {
    URL url;
    HttpURLConnection connection = null;  
	String targetURL = foAString[0];
    try {
      //Create connection
      url = new URL(targetURL);
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
