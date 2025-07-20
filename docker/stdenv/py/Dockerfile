# /* ex: set filetype=sh fenc=utf-8 expandtab ts=4 sw=4 : */
FROM shk3bq4d/stdenv:apt

# apt install python3-pip python3-setuptools python3-wheel
# sshuttle python3-sh python3-psutil python3-requests 

    #&& pip3 install --upgrade --user pip \
    # && pip install --upgrade --user pip \
RUN true \
    && pip3 install --break-system-packages --no-warn-script-location -U --user \
        pip \
        wheel \
        setuptools \
    && pip3 install --break-system-packages --no-warn-script-location --user \
        requests \
        sh \
        sshuttle \
        psutil \
    && sudo -i -u user \
        pip3 install --break-system-packages --no-warn-script-location -U --user \
        pip \
        wheel \
        setuptools \
    && sudo -i -u user \
        pip3 install --break-system-packages --no-warn-script-location --user \
        requests \
        sh \
        sshuttle \
        psutil \
    && date > /.dockerenv-py \
    && true

ENTRYPOINT ["/root/entrypoint.sh"]
