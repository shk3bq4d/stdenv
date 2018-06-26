import javax.net.ssl.*;
import java.io.*;
import java.net.*;
import java.security.*;

public class Bip2 {

  public static void main(String args[]) throws Exception {

    String urlString = (args.length == 1) ? 
      args[0] : "http://www.verisign.com/index.html";
    URL url = new URL(urlString);

    Security.addProvider(
      new com.sun.net.ssl.internal.ssl.Provider());

    SSLSocketFactory factory = 
      (SSLSocketFactory)SSLSocketFactory.getDefault();
    SSLSocket socket = 
      (SSLSocket)factory.createSocket(url.getHost(), 443);

    PrintWriter out = new PrintWriter(
        new OutputStreamWriter(
          socket.getOutputStream()));
	String r= "GET " + url.getPath() + " HTTP/1.1";
	r= "GET " + urlString + " HTTP/1.1";
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
