/* ex: set ts=8   : */

keyboard shortcuts
 F2			Doc
 F3			Open Declaration

 Ctrl F6		Next Editor

 Ctrl Shift F6		Previous Editor
 Ctrl Shift G		Usage
 Ctrl Shift O		Organize Imports
 Ctrl Shift R		Open files quickly

 Alt  Shift R		Refactor rename

 Ctrl H			Search
 Ctrl .			Go to next error
 Ctrl ,			Go to previous error
 Ctrl 1			Show quick fixes

log4j configuration while run in Console fix proposals:
1) add -Dlog4j.debug to your VM environment startup properties to have log4j print
out it's debugging info - perhaps a different log4j configuration file is being
picked up on the classpath (such as one bundled inside a JAR) than the one you intend 
2) Go to Run configurations in your eclipse then -VM arguments add this:
-Dlog4j.configuration=log4j-config_folder/log4j.xml
Possibly hard code it with an absolute file on the file system
3) add dummy log4j.properties at root of src/ directory and makes sure the include
of the build path includes that file


