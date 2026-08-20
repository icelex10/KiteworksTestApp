FROM ghcr.io/stefanprodan/podinfo:6.14.0

EXPOSE 9898

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
CMD wget -qO- http://localhost:9898/healthz || exit 1
