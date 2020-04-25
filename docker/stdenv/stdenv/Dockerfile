FROM shk3bq4d/stdenv:py

RUN true

COPY dot.stdenv /tmp
RUN bash -x /tmp/dot.stdenv
RUN sudo -i -u user bash -x /tmp/dot.stdenv

RUN true \
	&& chsh -s /usr/bin/zsh \
	&& chsh -s /usr/bin/zsh user \
	&& true

ENTRYPOINT ["/root/entrypoint.sh"]
