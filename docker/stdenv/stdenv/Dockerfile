FROM shk3bq4d/stdenv:py

COPY dot.stdenv /tmp
RUN true \
    && chmod a+rx /tmp/dot.stdenv \
    && bash -x /tmp/dot.stdenv \
    && sudo -i -u user bash -x /tmp/dot.stdenv \
    && chsh -s /usr/bin/zsh \
    && chsh -s /usr/bin/zsh user \
    && date > /.dockerenv-env \
    && true

VOLUME /stdenv

COPY entrypoint-stdenv.sh /root/

ENTRYPOINT ["/root/entrypoint-stdenv.sh"]
