#!/bin/sh

debugbox_dir=${HOME}/.k8s-debug-pod

findWritablePathDir()
{
    old_ifs="$IFS"
    IFS=:
    for dir in $PATH; do
        if [ -w $dir ]; then
            IFS="$old_ifs"
            echo "$dir"
            return 0
        fi
    done
    IFS="$old_ifs"
    return 1
}

if [ ! -e bin/k8s-debug-pod ]; then
    echo "'$(basename "$0")' must be run in 'k8s-debug-pod' directory!" >&2
    exit 1
fi

echo "Copying static binaries to '${debugbox_dir}'"
mkdir -p ${debugbox_dir}
cp -r box ${debugbox_dir}

if writable_path_dir="$(findWritablePathDir)"; then
    echo "Copying 'k8s-debug-pod' script to '${writable_path_dir}'"
    cp bin/k8s-debug-pod "${writable_path_dir}"
    if command -v bash.exe >/dev/null 2>&1; then
        cp bin/k8s-debug-pod.bat "${writable_path_dir}"
    fi
else
    echo "Can't find writable directory in PATH. Please add bin/k8s-debug-pod to PATH manually!"
fi
