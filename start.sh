#!/bin/sh
set -e

# Set default values for environment variables if not provided
export PORT=${PORT:-8080}
export FABIO_ROUTE_PATH=${FABIO_ROUTE_PATH:-/}
export FABIO_BACKEND_PROTOCOL=${FABIO_BACKEND_PROTOCOL:-http}
export FABIO_BACKEND_HOST=${FABIO_BACKEND_HOST:-core.railway.internal}
export FABIO_BACKEND_PORT=${FABIO_BACKEND_PORT:-8000}
export FABIO_BACKEND_PATH=${FABIO_BACKEND_PATH:-/}
export FABIO_ROUTE_OPTIONS=${FABIO_ROUTE_OPTIONS:-strip=/}
export FABIO_HEALTH_PATH=${FABIO_HEALTH_PATH:-/health}
export FABIO_HEALTH_CHECK=${FABIO_HEALTH_CHECK:-check:http://200}
export FABIO_MAX_CONN=${FABIO_MAX_CONN:-10000}
export FABIO_READ_TIMEOUT=${FABIO_READ_TIMEOUT:-30s}
export FABIO_WRITE_TIMEOUT=${FABIO_WRITE_TIMEOUT:-30s}
export FABIO_IDLE_TIMEOUT=${FABIO_IDLE_TIMEOUT:-120s}
export FABIO_SHUTDOWN_WAIT=${FABIO_SHUTDOWN_WAIT:-10s}
export FABIO_DIAL_TIMEOUT=${FABIO_DIAL_TIMEOUT:-10s}
export FABIO_KEEPALIVE_TIMEOUT=${FABIO_KEEPALIVE_TIMEOUT:-120s}
export FABIO_LOG_LEVEL=${FABIO_LOG_LEVEL:-WARN}
export log_level=${FABIO_LOG_LEVEL:-WARN}
export FABIO_LOG_ACCESS_TARGET=${FABIO_LOG_ACCESS_TARGET:-stdout}
export FABIO_LOG_ACCESS_FORMAT=${FABIO_LOG_ACCESS_FORMAT:-combined}
export FABIO_LB_STRATEGY=${FABIO_LB_STRATEGY:-rnd}
export FABIO_REGISTRY_BACKEND=${FABIO_REGISTRY_BACKEND:-static}

# Generate fabio.properties from template with environment variable substitution
envsubst < /etc/fabio/fabio.properties.template > /etc/fabio/fabio.properties

# Debug: Print the generated configuration to stderr so Railway shows it correctly
echo "=== Generated fabio.properties ==="
cat /etc/fabio/fabio.properties
echo "=== End of configuration ==="

# Start fabio with the generated configuration
exec fabio -cfg /etc/fabio/fabio.properties