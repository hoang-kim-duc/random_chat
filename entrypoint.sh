#!/bin/bash
set -e
export RAILS_ENV=production
export SECRET_KEY_BASE=secret key
export RAILS_SERVE_STATIC_FILES=false
# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
