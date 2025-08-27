FROM fabiolb/fabio:latest

# Install envsubst (gettext-base) for environment variable substitution
RUN apk add --no-cache gettext

# Create non-root user for running Fabio
RUN adduser -D -s /bin/sh fabio

# Copy configuration template and startup script
COPY fabio.properties.template /etc/fabio/fabio.properties.template
COPY start.sh /etc/fabio/start.sh

# Make startup script executable and set ownership
RUN chmod +x /etc/fabio/start.sh && \
    chown -R fabio:fabio /etc/fabio

# Switch to non-root user
USER fabio

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["wget", "-q", "--spider", "http://localhost:${PORT}/health"]

# Fabio will read PORT from env
EXPOSE ${PORT}

CMD ["/etc/fabio/start.sh"]