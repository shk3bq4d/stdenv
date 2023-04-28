# how to connect
from http://www.h2database.com/html/download.html , download jar

java -jar ~/Downloads/h2-2.1.214.jar

http://127.0.1.1:8082/login.jsp?
URL looks like
jdbc:h2:~/git/github/wso2/product-apim/modules/integration/tests-integration/tests-restart/target/carbontmp1682019988527/wso2am-4.2.0/repository/database/WSO2CARBON_DB
IMPORTANT: don't include .mv.db in filepath jdbc url


SCRIPT TO 'dump.sql';        -- dump database
SCRIPT SIMPLE TO 'dump.txt'; -- dump only schema
SCRIPT SIMPLE TO 'shared.sql'; -- dump only schema

# dump
```sh
echo "SCRIPT TO 'db-dump.sql'" > query.sql
java -cp ~/Downloads/h2-2.1.214.jar org.h2.tools.RunScript -url "jdbc:h2:file:./vocablesDb" -user username -password pazzword -script query.sql -showResults
echo "SCRIPT TO 'db-dump.sql'" | java -cp ~/Downloads/h2-2.1.214.jar org.h2.tools.RunScript -url "jdbc:h2:file:$HOME/git/github/wso2/product-apim/modules/integration/tests-integration/tests-restart/target/carbontmp1682019988527/wso2am-4.2.0/repository/database/WSO2CARBON_DB" -user wso2carbon -password wso2carbon -script '/dev/stdin' -showResults
echo "SCRIPT TO '/dev/stdout'" | java -cp ~/Downloads/h2-2.1.214.jar org.h2.tools.RunScript -url "jdbc:h2:file:$HOME/git/github/wso2/product-apim/modules/integration/tests-integration/tests-restart/target/carbontmp1682019988527/wso2am-4.2.0/repository/database/WSO2CARBON_DB" -user wso2carbon -password wso2carbon -script '/dev/stdin'
```
