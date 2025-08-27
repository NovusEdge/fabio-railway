FROM fabiolb/fabio:latest

COPY fabio.properties /etc/fabio/fabio.properties

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["wget", "-q", "--spider", "http://localhost:${PORT}/health"]

# Fabio will read PORT from env
EXPOSE ${PORT}

CMD ["fabio", "-cfg", "/etc/fabio/fabio.properties"]