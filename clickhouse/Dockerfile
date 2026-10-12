# Dittofeed's event store. Stock image (it already listens on :: for Railway's
# IPv6 private network) plus one config file: logs go to the console instead
# of 10 x 1 GB files, and ClickHouse's own telemetry tables (trace_log,
# metric_log, ...) are off — their constant writes and merges kept idle
# memory climbing.
FROM clickhouse/clickhouse-server:24.12.6.70-alpine

COPY railway.xml /etc/clickhouse-server/config.d/railway.xml

# Railway hosts run transparent huge pages "always": jemalloc frees 4K pages
# inside 2 MB huge pages that stay charged, so idle ClickHouse creeps.
ENV MALLOC_CONF=thp:never
