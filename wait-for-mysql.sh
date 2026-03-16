#!/bin/bash
# wait-for-mysql.sh - wait for MySQL to be ready

set -e

host="$1"
port="$2"
shift 2
cmd="$@"

echo "Waiting for MySQL at $host:$port to be ready..."

# Wait for MySQL to be ready
until nc -z "$host" "$port"; do
  echo "MySQL is not ready yet - sleeping"
  sleep 2
done

echo "MySQL is up - executing command"
exec $cmd 