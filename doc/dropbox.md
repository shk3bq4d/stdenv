
 8 down vote
 	
 Install Dropbox via command line

 The Dropbox daemon works fine on all 32-bit and 64-bit Linux servers. To install, run the following command in your Linux terminal.

 32-bit:
 $ cd ~ && wget -O - "http://www.dropbox.com/download?plat=lnx.x86" | tar xzf -

 64-bit:
 $ cd ~ && wget -O - "http://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

 Next, run the Dropbox daemon from the newly created .dropbox-dist folder.
 $ ~/.dropbox-dist/dropboxd 
