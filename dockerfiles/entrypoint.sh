#!/bin/sh
set -e

BINARY_PATH=/opt/rel/daily_growl/bin/daily_growl

exec $BINARY_PATH "$@"
