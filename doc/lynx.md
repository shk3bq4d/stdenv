
SSL_CERT_DIR=DIRPATH lynx
SSL_CERT_FILE=FILEPATH lynx



       -dump  dumps  the  formatted  output  of  the  default document or those specified on the
              command line to standard output.   Unlike  interactive  mode,  all  documents  are
              processed.  This can be used in the following way:

                  lynx -dump http://www.subir.com/lynx.html

              Files  specified on the command line are formatted as HTML if their names end with
              one of the standard web suffixes such as “.htm” or “.html”.  Use  the  -force_html
              option to format files whose names do not follow this convention.
