#!/bin/sh

echo "Unpacking JRE"
zstd --decompress /opt/jre-minimal.tar.zst -o /tmp/jre-minimal.tar
tar -xf /tmp/jre-minimal.tar -C /tmp

echo "Starting Java application..."
echo "--------------------------------------------------"
java -jar /backend/app.jar &
java_pid=$!

stop_java() {
  echo "Stopping Java application..."
  kill -15 $java_pid
  wait $java_pid
}

trap stop_java SIGTERM
trap stop_java SIGINT

wait $java_pid
