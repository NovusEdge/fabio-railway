FROM fabiolb/fabio:latest

# Install envsubst (gettext-base) for environment variable substitution
RUN apk add --no-cache gettext

# Copy configuration template and startup script
COPY fabio.properties.template /etc/fabio/fabio.properties.template
COPY start.sh /etc/fabio/start.sh

# Make startup script executable
RUN chmod +x /etc/fabio/start.sh

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["wget", "-q", "--spider", "http://localhost:${PORT}/health"]

# Fabio will read PORT from env
EXPOSE ${PORT}

CMD ["/etc/fabio/start.sh"]