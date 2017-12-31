curl -s http://localhost:8500/v1/catalog/service/download | jq  -e -r '.[].ServiceEnableTagOverride'
python -m json.tool my_json.json # json prettifyer
python -m json.tool
