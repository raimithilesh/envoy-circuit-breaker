#!/bin/sh
/usr/bin/dumb-init /bin/sh
envoy -l debug -c /etc/front-envoy.yaml --service-cluster front-proxy
