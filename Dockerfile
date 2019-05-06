FROM alpine:3.9 as builder
WORKDIR /usr/local/k8s-debugbox
COPY . .
RUN apk add -U curl && ./bootstrap.sh

FROM busybox
COPY --from=builder /usr/local/k8s-debugbox /usr/local/k8s-debugbox
CMD ["/bin/sh", "/usr/local/k8s-debugbox/box/install-k8s-debugbox.sh"]
