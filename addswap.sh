#!/bin/bash

SWAPFILE='/swap'

if grep -q "${SWAPFILE}\b" /proc/swaps; then
  echo 'swap exists, skipping addswap'
  exit 0
fi

dd if=/dev/zero of="${SWAPFILE}" bs=1M count=512

mkswap "${SWAPFILE}"

chmod 0600 "${SWAPFILE}"

swapon "${SWAPFILE}"