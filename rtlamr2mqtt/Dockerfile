ARG BUILD_FROM=irakhlin/rtlamr2mqtt:main
FROM ${BUILD_FROM}

# Copy data
COPY data/run.sh /

RUN chmod +x /run.sh

CMD [ "/run.sh" ]
