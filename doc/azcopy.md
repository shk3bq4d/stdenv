RUN wget -O azcopyv10.tar https://aka.ms/downloadazcopy-v10-linux && \
    tar -xf azcopyv10.tar && \
    mkdir /app && \
    mv azcopy_linux_amd64_*/azcopy /app/azcopy && \
    rm -rf azcopy* && \
