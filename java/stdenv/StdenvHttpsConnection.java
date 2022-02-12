import javax.net.ssl.*;
import java.io.*;
import java.net.*;
import java.security.*;

public class StdenvHttpsConnection {

  public static void main(String foAString[]) throws Exception {

    String target = (foAString.length >= 1) ?  foAString[0] : "https://127.0.0.1";
    int port = (foAString.length >= 2) ?  Integer.parseInt(foAString[1]) : 443;
    URL url = new URL(target);
	System.out.printf("Trying to https GET %s on target port %d\n", target, port);

//  Security.addProvider(
//    new com.sun.net.ssl.internal.ssl.Provider());

    SSLSocketFactory factory = 
      (SSLSocketFactory)SSLSocketFactory.getDefault();
    SSLSocket socket = 
      (SSLSocket)factory.createSocket(url.getHost(), port);

    PrintWriter out = new PrintWriter(
        new OutputStreamWriter(
          socket.getOutputStream()));
	String r= "GET " + url.getPath() + " HTTP/1.1";
	r= "GET " + target + " HTTP/1.1";
	System.out.println(r);
    out.print(r);
    out.print("\r\n\r\n");
    out.flush();

    BufferedReader in = new BufferedReader(
      new InputStreamReader(
      socket.getInputStream()));

    String line;

    while ((line = in.readLine()) != null) {
      System.out.println(line);
    }

    out.close();
    in.close();
  }
}
