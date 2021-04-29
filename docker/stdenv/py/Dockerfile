FROM shk3bq4d/stdenv:apt

	#&& pip3 install --upgrade --user pip \
	# && pip install --upgrade --user pip \
RUN true \
	&& pip3 install --no-warn-script-location -U --user \
		pip \
		wheel \
		setuptools \
	&& pip3 install --no-warn-script-location --user \
		requests \
		sh \
		sshuttle \
		psutil \
	&& true

ENTRYPOINT ["/root/entrypoint.sh"]
