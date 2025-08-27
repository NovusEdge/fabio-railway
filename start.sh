#!/bin/sh
set -e

# Generate fabio.properties from template with environment variable substitution
envsubst < /etc/fabio/fabio.properties.template > /etc/fabio/fabio.properties

# Debug: Print the generated configuration
echo "=== Generated fabio.properties ==="
cat /etc/fabio/fabio.properties
echo "=== End of configuration ==="

# Start fabio with the generated configuration
exec fabio -cfg /etc/fabio/fabio.properties