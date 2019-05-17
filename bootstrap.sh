#!/bin/sh

if [ ! -e bin/k8s-debug-pod ]; then
    echo "'$(basename "$0")' must be run in 'k8s-debug-pod' directory!" >&2
    exit 1
fi

echo "Downloading static-get utility:"
curl -Lo box/static-get http://s.minos.io/s
chmod +x box/static-get

echo
echo "Downloading static bind binary:"
./box/static-get -d box -v -x bind

echo
echo "Downloading static mtr binary:"
./box/static-get -d box -v -x mtr

echo
echo "Downloading static busybox binary:"
curl -Lo box/busybox https://busybox.net/downloads/binaries/1.28.1-defconfig-multiarch/busybox-x86_64
chmod +x box/busybox

echo
echo "Downloading static curl binary and CA bundle:"
curl -Lo box/cacert.pem https://curl.haxx.se/ca/cacert.pem
./box/static-get -d box -v -x curl

echo
echo "Downloading static vim binary:"
./box/static-get -d box -v -x vim

echo ""
echo "Downloading terminfo database."
./box/static-get -d box -v -x terminfo

rm -f box/*.xz
