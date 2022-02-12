import javax.net.ssl.*;
import java.io.*;
import java.net.*;
import java.security.*;

public class StdenvSSLSocketConnection {

  public static void main(String foAString[]) throws Exception {

    String target = (foAString.length >= 1) ?  foAString[0] : "127.0.0.1";
    int port = (foAString.length >= 2) ?  Integer.parseInt(foAString[1]) : 443;
	System.out.printf("Trying to connect to %s on target port %d\n", target, port);

//  Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());

    SSLSocketFactory factory = (SSLSocketFactory)SSLSocketFactory.getDefault();
    SSLSocket socket = (SSLSocket)factory.createSocket(target, port);

    BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
    System.out.println("Connected");
    String line;

    while ((line = in.readLine()) != null) {
      System.out.println(line);
    }

    in.close();
  }
}
