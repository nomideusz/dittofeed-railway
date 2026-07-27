#!/bin/sh
# Wire Railway env onto dittofeed-lite. The lite image bundles the API,
# dashboard, and worker behind one HTTP port (Next.js honors PORT, default 3000).
set -e

# The dashboard calls the API on the same origin — derive it from the
# Railway domain so it works before the deployer touches any variable.
if [ -z "$DASHBOARD_API_BASE" ] && [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
  export DASHBOARD_API_BASE="https://${RAILWAY_PUBLIC_DOMAIN}"
fi

exec node --max-old-space-size="${LITE_MEM_LIMIT:-824}" \
  ./packages/lite/dist/scripts/startLite.js \
  --workspace-name="${WORKSPACE_NAME:-Default}"
