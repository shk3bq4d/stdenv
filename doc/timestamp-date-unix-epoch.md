date -d @1465016400 # unix epoch timestamp
python -c "import datetime; print(datetime.datetime.fromtimestamp(1532532080))" # unix epoch timestamp

RFC3339: 2014-03-10T05:40:00+00:00

Sep 28 2021 01:33:21      date +'%b %d %Y %H:%M:%S'
Sep 28 2021 01:33:21      sed -r -e "s/^[A-Z][a-z]{2} [ 0-9]?[0-9].{14}/$(date +'%b %d %Y %H:%M:%S')/"

%m/%b/%y %I:%M %p    09/Sep/21 09:33 AM
