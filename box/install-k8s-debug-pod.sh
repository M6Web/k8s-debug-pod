#!/tmp/box/busybox sh

if [ ! -e /tmp/box/bin/sh ]; then
  mkdir -p /tmp/box/bin

  if [ ! -e /tmp/box/cacert.pem ]; then
    cp -r /usr/local/k8s-debug-pod/box/* /tmp/box
  fi

  for dir in /tmp/box/bind*/ /tmp/box/terminfo*/ /tmp/box/vim*/ /tmp/box/curl*/ ; do cp -R "$dir"/* /tmp/box/ ; rm -rf /tmp/box/"$(basename "$dir")" ; done

  echo "Installing Busybox"
  /tmp/box/busybox --install /tmp/box/bin

  [ -e /tmp/box/sh ] || cp /usr/local/k8s-debug-pod/box/sh /tmp/box/sh
  chmod 0755 /tmp/box/sh
fi
