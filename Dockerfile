FROM ghcr.io/stefanprodan/podinfo:6.14.0

ARG IMAGE_TAG=local
ENV PODINFO_UI_MESSAGE="Kiteworks | build ${IMAGE_TAG}"

EXPOSE 9898

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
CMD wget -qO- http://localhost:9898/healthz || exit 1
