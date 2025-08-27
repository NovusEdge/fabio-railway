# Fabio Load Balancer - Railway Template

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/fabio-lb)

A highly configurable [Fabio](https://fabiolb.net/) HTTP/HTTPS load balancer template for Railway. Perfect for routing traffic to your Railway services with zero-downtime deployments and automatic service discovery.

## 🚀 Features

- **Zero Configuration**: Works out of the box with sensible defaults
- **Fully Customizable**: All settings configurable via environment variables
- **Railway Optimized**: Designed specifically for Railway's internal networking
- **High Performance**: Handles 10,000+ concurrent connections by default
- **Health Checks**: Built-in health monitoring endpoints
- **Metrics Support**: Prometheus metrics integration ready
- **TLS Support**: HTTPS/SSL termination capabilities

## 📦 Quick Deploy

1. Click the "Deploy on Railway" button above
2. Configure your backend service (defaults to `core.railway.internal:8000`)
3. Deploy and your load balancer is ready!

## ⚙️ Configuration

All configuration is done through environment variables. Here are the key settings:

### Backend Configuration

| Variable                 | Default                 | Description                   |
| ------------------------ | ----------------------- | ----------------------------- |
| `FABIO_BACKEND_HOST`     | `core.railway.internal` | Backend service hostname      |
| `FABIO_BACKEND_PORT`     | `8000`                  | Backend service port          |
| `FABIO_BACKEND_PROTOCOL` | `http`                  | Backend protocol (http/https) |
| `FABIO_BACKEND_PATH`     | `/`                     | Backend service path          |
| `FABIO_ROUTE_PATH`       | `/`                     | Route path to match           |
| `FABIO_ROUTE_OPTIONS`    | `strip=/`               | Route options                 |

### Performance Tuning

| Variable                  | Default | Description                               |
| ------------------------- | ------- | ----------------------------------------- |
| `FABIO_MAX_CONN`          | `10000` | Maximum concurrent connections            |
| `FABIO_READ_TIMEOUT`      | `30s`   | Read timeout                              |
| `FABIO_WRITE_TIMEOUT`     | `30s`   | Write timeout                             |
| `FABIO_IDLE_TIMEOUT`      | `120s`  | Idle connection timeout                   |
| `FABIO_DIAL_TIMEOUT`      | `10s`   | Backend dial timeout                      |
| `FABIO_KEEPALIVE_TIMEOUT` | `120s`  | Keep-alive timeout                        |
| `FABIO_LB_STRATEGY`       | `rnd`   | Load balancing strategy (rnd, rr, iphash) |

### Logging & Monitoring

| Variable                        | Default    | Description                                |
| ------------------------------- | ---------- | ------------------------------------------ |
| `FABIO_LOG_LEVEL`               | `INFO`     | Log level (DEBUG, INFO, WARN, ERROR)       |
| `FABIO_LOG_ACCESS_TARGET`       | `stdout`   | Access log target                          |
| `FABIO_LOG_ACCESS_FORMAT`       | `combined` | Access log format                          |
| `FABIO_METRICS_TARGET`          | ``         | Metrics target (prometheus, graphite, etc) |
| `FABIO_METRICS_PROMETHEUS_ADDR` | `:9998`    | Prometheus metrics port                    |

### Health Checks

| Variable             | Default            | Description                |
| -------------------- | ------------------ | -------------------------- |
| `FABIO_HEALTH_PATH`  | `/health`          | Health check endpoint path |
| `FABIO_HEALTH_CHECK` | `check:http://200` | Health check configuration |

### Service Discovery (Optional)

For Consul integration:

| Variable        | Default | Description              |
| --------------- | ------- | ------------------------ |
| `CONSUL_ADDR`   | ``      | Consul server address    |
| `CONSUL_SCHEME` | `http`  | Consul connection scheme |
| `CONSUL_TOKEN`  | ``      | Consul ACL token         |

### TLS/SSL (Optional)

| Variable             | Default | Description                              |
| -------------------- | ------- | ---------------------------------------- |
| `FABIO_CERT_SOURCE`  | ``      | Certificate source (file, consul, vault) |
| `FABIO_CERT_CAUPGCN` | ``      | CA certificate upgrade CN                |

## 🏗️ Architecture

```
Internet → Railway Edge → Fabio Load Balancer → Your Backend Services
                           |
                           └→ Health Checks
                           └→ Metrics (optional)
```

## 💡 Common Use Cases

### Basic HTTP Proxy

```bash
# No configuration needed - works with defaults
# Routes all traffic to core.railway.internal:8000
```

### Custom Backend Service

```bash
FABIO_BACKEND_HOST=api.railway.internal
FABIO_BACKEND_PORT=3000
```

### Multiple Route Handling

```bash
# Route API traffic to different backend
FABIO_ROUTE_PATH=/api/
FABIO_BACKEND_PATH=/v1/
FABIO_ROUTE_OPTIONS="strip=/api"
```

### Enable Metrics

```bash
FABIO_METRICS_TARGET=prometheus
# Access metrics at http://your-service:9998/metrics
```

### Debug Mode

```bash
FABIO_LOG_LEVEL=DEBUG
```

## 📊 Monitoring

- **Health Check**: `GET /health` - Returns 200 if healthy
- **Prometheus Metrics**: Available at `:9998/metrics` (when enabled)
- **Access Logs**: Streamed to stdout in combined format

## 🔧 Advanced Configuration

### Load Balancing Strategies

- `rnd` (default): Random selection
- `rr`: Round-robin
- `iphash`: IP-based hashing for session affinity

### Custom Routing Rules

Add additional routes by modifying the `fabio.properties` file or using Consul for dynamic configuration.

## 📝 Local Development

1. Clone this repository
2. Set environment variables in `.env` file
3. Run with Docker: `docker build -t fabio-lb . && docker run -p 9999:9999 fabio-lb`

## 🤝 Contributing

This template is open source and welcomes contributions. Please submit issues and pull requests on GitHub.

## 📄 License

This template is provided under the MIT License. Fabio itself is also MIT licensed.

## 🔗 Links

- [Fabio Documentation](https://fabiolb.net/)
- [Railway Documentation](https://docs.railway.app/)
- [Template Source Code](https://github.com/NovusEdge/fabio-railway)
