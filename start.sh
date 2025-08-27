#!/bin/sh
set -e

# Generate fabio.properties from template with environment variable substitution
envsubst < /etc/fabio/fabio.properties.template > /etc/fabio/fabio.properties

# Start fabio with the generated configuration
exec fabio -cfg /etc/fabio/fabio.properties