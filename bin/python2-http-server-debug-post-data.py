from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import SimpleHTTPServer
import SocketServer
import logging
import cgi
import json
from pprint import pprint

PORT = 7000

class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):

    def do_GET(self):
        pprint(self.headers)
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

    def do_POST(self):
        print("POST")
        pprint(self.headers)
        post = self.rfile.read(int(self.headers.get('Content-Length', 0)))
        print("Post Body:")
        try:
            pprint(json.loads(post))
        except:
            if len(post) == 0:
                print("EMPTY POST BODY")
            else:
                print(post)
        SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)

Handler = ServerHandler

SocketServer.TCPServer.allow_reuse_address = True
httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()
