FROM alpine:3.9 as builder
WORKDIR /usr/local/k8s-debug-pod
COPY . .
RUN apk add -U curl && ./bootstrap.sh

FROM busybox
COPY --from=builder /usr/local/k8s-debug-pod /usr/local/k8s-debug-pod
CMD ["/bin/sh", "/usr/local/k8s-debug-pod/box/install-k8s-debug-pod.sh"]
