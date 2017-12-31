http://stackoverflow.com/questions/5194552/is-it-possible-to-copy-all-files-from-one-s3-bucket-to-another-with-s3cmd

http://docs.pythonboto.org/en/latest/boto_config_tut.html

http://adrianotto.com/2010/09/openstack-os-is-great-for/

http://boto3.readthedocs.io/en/latest/guide/configuration.html#configuration-file

mysqldump $MYSQL_HOST_OPTS $MYSQLDUMP_OPTIONS $MYSQLDUMP_DATABASE | gzip | aws s3 cp - s3://$AWS_BUCKET/$PREFIX/$(date +"%Y")/$(date +"%m")/$(date +"%d").sql.gz #https://github.com/ianneub/mysqldump-to-s3 
